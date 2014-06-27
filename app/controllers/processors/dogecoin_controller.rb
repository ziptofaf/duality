class Processors::DogecoinController < ApplicationController
include CryptoHelper
skip_before_action :authorize, only: [:listen]
def index
 begin
guid="3176_53256c8198aeb"
processor_id=(Processor.find_by name: "dogecoin").id
  error_message and redirect_to root_path and return unless (flash[:amount] && flash[:type]=="dogecoin")
    json_hash=create_a_payment_url(flash[:amount], guid, "dogecoin")
    insert_into_db(json_hash, flash[:amount], session[:user_id], processor_id)
    @type="dogecoin"
    @amount=(flash[:amount].split(',').join('.').to_f.round(2))
    @url=json_hash["url"]
 rescue => e
 end
end

def listen
  begin
    redirect_to root_path and return unless listen_params[:ipn_secret]==secret_ipn
    update_payment(listen_params[:status], listen_params[:tx])
    redirect_to root_path and return 
 rescue => e
redirect_to root_path and return
 end
end

protected
def listen_params
 params.permit(:tx, :timestamp, :status, :ipn_secret)
end
end
