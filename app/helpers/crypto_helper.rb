module CryptoHelper
require 'json'
require 'rest_client'
require 'open-uri' #this will need to be removed

	def secret_api
    return 'a953-a6--c264e29-0f50006b9f72e46bb14'
	end

  def public_api
    return 'b1a4ef4-16-d00b--156fee58bbc74af30cc'
  end

	def create_a_payment_url(amount, processor, ipn)
		begin
			link="https://api.moolah.io/v2/private/merchant/create"
			arguments = {"apiKey"=>public_api, "coin"=>processor, "currency"=>"usd", "amount"=>amount, "product"=>"Duality VPN wallet funds", "apiSecret"=>secret_api, "ipn"=>ipn}
			response = RestClient.post link, arguments
                	response = JSON.parse(response)
			raise 'Couldnt create a valid url' unless response["status"]=="success"
			return response
		rescue
			raise 'Something went wrong with accessing moolah'
		end
	end

	def insert_into_db(json_hash, amount, user_id, processor_id)
		raise 'json hash is empty!' if json_hash==false
		payment = Payment.new
		payment.user_id=user_id
		payment.tx=json_hash["guid"]
		payment.processor_id=processor_id
		payment.user_id=user_id
		payment.amount=amount
		payment.status="pending"
		logger.error "cannot save record!" and raise 'cant save the record into db' unless payment.save
	end

	def update_payment(_status, _tx)
		payment = Payment.find_by(tx: _tx)
		logger.error "tx : #{_tx} was found invalid" and raise 'invalid tx' unless payment
		if _status=="complete" && payment.status=="pending"
      logger.error "failed double authorization!" and raise 'double authorization failed' unless double_authorization(_tx)
			user = User.find(payment.user_id)
			wallet=user.balance
			wallet+=((payment.amount)*1.1).round(2)
			user.update_attribute(:balance, wallet)
			payment.status="complete"
			logger.error "Problem with saving record into payment database" and raise "Cant save record to the database" unless payment.save
			return true
		else
			payment.status=_status if payment.status!="complete"
			logger.error "Problem with saving record into payment database" and raise "Cant save record to the database" unless payment.save
			return true
		end

	end

	def double_authorization(_tx)
		link="https://api.moolah.io/v2/private/merchant/status"
		arguments = {"apiKey"=>public_api, "guid"=>_tx}
		response = RestClient.post link, arguments
		response = JSON.parse(response)
		#return response
		return true if response["status"]=="success" #and response["transaction"]["tx"]["status"]=="complete"
		return false
	end
end
