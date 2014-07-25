class Processors::PaypalController < ApplicationController
skip_before_action :authorize, only: [:listen]
skip_before_action :verify_authenticity_token, only: [:listen]
include PaypalHelper
def index
error_message and redirect_to root_path and return unless (flash[:amount] && flash[:type]=="paypal") 
@button = "placeholder" and @type="paypal" and @amount=(flash[:amount].to_s.split(',').join('.').to_f.round(2)) and return if Rails.env.development? or Rails.env.test?
payment = insert_into_db(session[:user_id], flash[:amount])
@amount = flash[:amount]
@type = "paypal"
@button = create_button(payment)
end

def listen
 begin
 render :nothing => true 
 respond_to_paypal(params)
 payment = check_if_exists(params)
 process_payment(payment, params)
  
 rescue => e
  
 end
end

end
