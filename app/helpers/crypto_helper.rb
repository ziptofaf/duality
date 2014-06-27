module CryptoHelper
require 'json'
require 'open-uri'

	def create_a_payment_url(amount,guid, processor)
		begin
			request="https://moolah.io/api/pay?guid={guid}&currency=USD&amount={amount}&product=Add_Wallet_Funds&return=http://dualitynetwork.com&ipn=http://dualitynetwork.com/processors/listen/{proc_name}"
			request["{guid}"]=guid
			request["{amount}"]=(amount.to_s)
			request["{proc_name}"]=processor
			response = open(request)
   		        response = response.read
			response=JSON.parse(response)
			raise 'Couldnt create a valid url' if response["status"]=="failure"
			return response
		rescue
			raise 'Something went wrong with accessing moolah'
		end
	end
	
	def insert_into_db(json_hash, amount, user_id, processor_id)
		raise 'json hash is empty!' if json_hash==false
		payment = Payment.new
		payment.user_id=user_id
		payment.tx=json_hash["tx"]
		payment.processor_id=processor_id
		payment.user_id=user_id
		payment.amount=amount
		payment.status="pending"
		logger.error "cannot save record!" and raise 'cant save the record into db' unless payment.save==true
	end
	
	def secret_ipn
		return 'J1kFLAoRtOx1vX9GxKxK'
	end	
	
	def update_payment(_status, _tx)
		payment = Payment.find_by(tx: _tx)
		logger.error "tx : #{_tx} was found invalid" and raise 'invalid tx' unless payment
		if _status=="complete" && payment.status=="pending"
                        logger.error "failed double authorization!" and raise 'double authorization failed' unless double_authorization(_tx)==true
			user = User.find(payment.user_id)
			wallet=user.balance
			wallet+=((payment.amount)*1.05).round(2)
			user.update_attribute(:balance, wallet)
			payment.status="complete"
			logger.error "Problem with saving record into payment database" and raise "Cant save record to the database" unless payment.save==true
			return true
		else
			payment.status=_status if _status=="cancelled" && payment.status=="pending"
			logger.error "Problem with saving record into payment database" and raise "Cant save record to the database" unless payment.save==true
			return true
		end
		
	end
	
	def double_authorization(_tx)
		link="https://moolah.io/api/pay/check/{tx}"
		link["{tx}"]=_tx
		response = open(link).read
		response = JSON.parse(response)
		return true if response["status"]=="complete"
		return false
		end
end
