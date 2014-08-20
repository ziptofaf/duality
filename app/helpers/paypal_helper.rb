module PaypalHelper
require 'rest_client'
require 'securerandom'

 def find_id
  id = (Processor.find_by name: "paypal").id
  return id
 end


 def create_button(payment)
  tx = payment.tx
  amount = payment.amount
  email = "wolframeye@gmail.com"
  url = "<form name=\"_xclick\" action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\">
<input type=\"hidden\" name=\"cmd\" value=\"_xclick\">
<input type=\"hidden\" name=\"business\" value=\"#{email}\">
<input type=\"hidden\" name=\"currency_code\" value=\"USD\">
<input type=\"hidden\" name=\"item_name\" value=\"Add DualityNetwork Funds\">
<input type=\"hidden\" name=\"amount\" value=\"#{amount}\">
<input type=\"hidden\" name=\"custom\" value=\"#{tx}\">
<input type=\"image\" src=\"http://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif\" border=\"0\" name=\"submit\" alt=\"Make payments with PayPal - it's fast, free and secure!\">
</form>"
 return url
 end

 def insert_into_db(user_id, amount)
  payment = Payment.new
  payment.user_id=user_id
  payment.amount=amount
  payment.processor_id=find_id
  payment.tx=SecureRandom.hex(15).to_s
  tx_copy = payment.tx
  payment.status="pending"
  raise "Couldn't save the record" and logger.error "Transaction_id: #{tx_copy}" unless payment.save
  return payment
 end


 def respond_to_paypal(arguments)
  respond_with= {"cmd" => '_notify-validate'}
  respond_with = respond_with.merge(arguments).except("action", "controller")
  url = 'https://www.paypal.com/cgi-bin/webscr'
  answer = RestClient.post "#{url}", respond_with
  raise "Invalid paypal transaction ID" unless answer.body.to_s=="VERIFIED"
  return
 end

  def check_if_exists(params)
   raise "Transaction doesn't exist!" unless Payment.exists?(:tx => params[:custom])
   payment = Payment.find_by tx: params[:custom]
   return payment
  end

  def process_payment(payment, params)
   raise "Transaction is already completed!" if payment.status=='complete'
   raise "This transaction wasnt paid or was paid via echeck!" unless params[:payment_status]=='Completed'
   raise "Prices do not match!" unless (payment.amount.round(2) == params[:mc_gross].to_f.round(2) or
				       payment.amount.round(2) == params[:mc_gross1].to_f.round(2))
   payment.status = "complete"
   user = User.find(payment.user_id)
   wallet=user.balance
   wallet+=payment.amount.round(2)
   logger.error "COULDN'T UPDATE USER #{user.email} BALANCE" unless user.update_attribute(:balance, wallet)
   logger.error "Problem with saving record into payment database" and raise "Cant save record to the database" unless payment.save==true
  end
end
