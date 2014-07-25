class Processors::DogecoinController < ApplicationController
include CryptoHelper
skip_before_action :authorize, only: [:listen]
skip_before_action :verify_authenticity_token, only: [:listen]
def index
 begin
#guid="3176_53256c8198aeb"
ipn = "http://dualitynetwork.com/processors/listen/dogecoin"
processor_id=(Processor.find_by name: "dogecoin").id
  error_message and redirect_to root_path and return unless (flash[:amount] && flash[:type]=="dogecoin")
    @url = "placeholder" and @type="dogecoin" and @amount=(flash[:amount].to_s.split(',').join('.').to_f.round(2)) and return if Rails.env.development? or Rails.env.test?
    json_hash=create_a_payment_url(flash[:amount], "dogecoin", ipn)
    @url=json_hash["url"].html_safe
    insert_into_db(json_hash, flash[:amount], session[:user_id], processor_id)
    @type="dogecoin"
    @amount=(flash[:amount].to_s.split(',').join('.').to_f.round(2))
    #@url=json_hash["url"].html_safe
 rescue => e
  error_message and redirect_to root_path and return
 end
end

def listen
  begin
    error_message and redirect_to root_path and return unless listen_params[:apiSecret]==secret_api
    update_payment(listen_params[:status], listen_params[:guid])
    redirect_to root_path and return
 rescue => e
redirect_to root_path and return
 end
end

protected
def listen_params
 params.permit(:tx, :guid, :timestamp, :status, :apiSecret, :ipn_extra)
end
end

