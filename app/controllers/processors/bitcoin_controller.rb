class Processors::BitcoinController < ApplicationController
include CryptoHelper
skip_before_action :authorize, only: [:listen]
skip_before_action :verify_authenticity_token, only: [:listen]
def index
 begin
#guid="3176_53256c81722e0"
ipn = "http://dualitynetwork.com/processors/listen/bitcoin"
processor_id=(Processor.find_by name: "bitcoin").id
  error_message and redirect_to root_path and return unless (flash[:amount] && flash[:type]=="bitcoin")
    @url = "placeholder" and @type="bitcoin" and @amount=(flash[:amount].to_s.split(',').join('.').to_f.round(2)) and return if Rails.env.development? or Rails.env.test?
    json_hash=create_a_payment_url(flash[:amount], "bitcoin", ipn)
    @url=json_hash["url"].html_safe
    insert_into_db(json_hash, flash[:amount], session[:user_id], processor_id)
    @type="bitcoin"
    @amount=(flash[:amount].to_s.split(',').join('.').to_f.round(2))
 rescue => e
 error_message and redirect_to root_path and return
 end
end

def listen
  begin
    redirect_to root_path and return unless listen_params[:apiSecret]==secret_api
    update_payment(listen_params[:status], listen_params[:guid])
    redirect_to root_path and return
 rescue => e
 end
end

protected
def listen_params
 params.permit(:tx, :guid, :timestamp, :status, :apiSecret, :ipn_extra)
end

end



