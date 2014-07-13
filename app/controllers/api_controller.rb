class ApiController < ApplicationController
skip_before_action :authorize
skip_before_action :verify_authenticity_token
respond_to :json

  def client_side
    return unless api_params[:email] && api_params[:password] && api_params[:api_key]
   user = User.find_by(email: api_params[:email].downcase)
  if user && user.active>=1 && user.authenticate(api_params[:password]) && api_params[:api_key]=='MsofNLIfkVI4p28028q4'
   @test = Account.joins(:user).joins(:server).where('user_id=? and expire>?', user.id, Time.now).select(:login, :password, :ip, :cert_url, :certname, :location, 'servers.level')
     else
   return
   end
  return     
  end

  def server_side
  @response = {'status'=>'failure'} and return unless api_params[:email] && api_params[:password] && api_params[:api_key]=='0mfd1INmx86TAzY3U25O' && api_params[:server_id]
   user = Account.find_by login: api_params[:email]
  @response = {'status'=>'failure'} and return unless user && user.server_id==api_params[:server_id].to_i && user.expire>Time.now && user.password==api_params[:password] && user.active<=1
  @response = {'status'=>'success'}
  user.active+=1
  user.save
  end

  def check_ip
   @response = {'ip'=> request.remote_ip}
  end

  def api_params
   params.permit(:email, :password, :api_key, :format, :server_id)
  end
  
  def logs_params
   params.permit(:username, :kilobytes_sent, :kilobytes_received, :remote_ip, :api_key, :session_length)
  end

 def disconnect
  @response = {'status'=>'failure'} and return unless logs_params[:username] && logs_params[:kilobytes_sent] && logs_params[:kilobytes_received] && logs_params[:api_key] && logs_params[:session_length]
  @response = {'status'=>'dupa1'} and return unless logs_params[:api_key]=='0mfd1INmx86TAzY3U25O'
  @response = {'status'=>'dupa2'} and return unless Account.exists?(:login => logs_params[:username])
  account = Account.find_by login: logs_params[:username]
  account.active = account.active - 1
  account.save
  log = AccountLog.new
  log.account_id=account.id
  log.kilobytes_sent=logs_params[:kilobytes_sent].to_i
  log.kilobytes_received=logs_params[:kilobytes_received].to_i
  log.remote = logs_params[:remote_ip]
  log.end = Time.now
  log.start = Time.now - logs_params[:session_length].to_i
  log.save
  @response = {'status'=>'success'}
#TODO: MAKE IT SHOVE ERROR MESSAGES UP YOUR ASS SO SERVER CAN RESEND THIS DATA (AKA EXCEPTIONS)
 end
end
