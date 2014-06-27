class Processors::BitcoinController < ApplicationController
include CryptoHelper
skip_before_action :authorize, only: [:listen]
def index
 begin
guid="3176_53256c81722e0"
processor_id=(Processor.find_by name: "bitcoin").id
  error_message and redirect_to root_path and return unless (flash[:amount] && flash[:type]=="bitcoin")
    json_hash=create_a_payment_url(flash[:amount], guid, "bitcoin")
    insert_into_db(json_hash, flash[:amount], session[:user_id], processor_id) 
    @type="bitcoin"
    @amount=(flash[:amount].split(',').join('.').to_f.round(2))
    @url=json_hash["url"]
 rescue => e
 redirect_to root_path and return
 end
end

def listen
  begin
    redirect_to root_path and return unless listen_params[:ipn_secret]==secret_ipn
    update_payment(listen_params[:status], listen_params[:tx])
    redirect_to root_path and return
 rescue => e
 end
end

protected
def listen_params
 params.permit(:tx, :timestamp, :status, :ipn_secret)
 end

end

