class ApiController < ApplicationController
skip_before_action :authorize
skip_before_action :verify_authenticity_token
respond_to :json

  def client_side
    return unless api_params[:email] && api_params[:password] && api_params[:api_key]
   user = User.find_by(email: api_params[:email].downcase)
  if user && user.active>=1 && user.authenticate(api_params[:password]) && api_params[:api_key]=='MsofNLIfkVI4p28028q4'
   @test = Server.joins(:accounts).where('accounts.user_id=? and accounts.expire>? ', user.id, Time.now).select("accounts.login", "accounts.password", "accounts.id", :ip, :cert_url, :certname, :location)
     else
   return
   end
  return
  end

  def server_side #REFACTOR FUCKING VARIABLE NAME TO ACCOUNT INSTEAD OF USER
  @response = {'status'=>'failure'} and return unless api_params[:login] && api_params[:password] && api_params[:api_key]=='0mfd1INmx86TAzY3U25O' && api_params[:server_id]
  account = Account.find_by login: api_params[:login]
  server = Server.find(api_params[:server_id])
  @response = {'status'=>'failure'} and return unless account && server && account.server_pool_id>=server.server_pool_id && account.expire>Time.now && account.password==api_params[:password] && account.active<=1
  @response = {'status'=>'success'}
  end

  def connect
    @response = {'status'=>'connection failure'} and return unless api_params[:login] && api_params[:api_key]=='0mfd1INmx86TAzY3U25O' && api_params[:server_id]
    account = Account.find_by login: api_params[:login]
    server = Server.find(api_params[:server_id])
   begin
    account.active+=1
    account.save!
    server.capacity_current+=1
    server.save!
    @response= {'status'=>'connection success'}
  rescue => e
    logger.fatal "#{e}"
    @response = {'status'=>'connection failure'}
  end

  end
  def check_ip
   @response = {'ip'=> request.remote_ip}
  end

  def api_params
   params.permit(:email, :login, :password, :api_key, :format, :server_id)
  end

  def logs_params
   params.permit(:username, :kilobytes_sent, :kilobytes_received, :remote_ip, :api_key, :session_length, :server_id)
   
  end

 def disconnect
  @response = {'status'=>'disconnection failure'} and return unless logs_params[:username] && logs_params[:kilobytes_sent] && logs_params[:kilobytes_received] && logs_params[:server_id] && logs_params[:api_key] && logs_params[:session_length]
  @response = {'status'=>'disconnection failure'} and return unless logs_params[:api_key]=='0mfd1INmx86TAzY3U25O'
  @response = {'status'=>'disconnection failure'} and logger.fatal "VPN with that username (#{logs_params[:username]}) SHOULDN'T EXIST. Security breach?" and return unless Account.exists?(:login => logs_params[:username])
   begin
  account = Account.find_by login: logs_params[:username]
  account.active = account.active - 1
  account.save!
  server = Server.find(logs_params[:server_id])
  server.capacity_current-=1
  server.save!
  log = AccountLog.new
  log.account_id=account.id
  log.kilobytes_sent=logs_params[:kilobytes_sent].to_i
  log.kilobytes_received=logs_params[:kilobytes_received].to_i
  log.remote = logs_params[:remote_ip]
  log.end = Time.now
  log.start = Time.now - logs_params[:session_length].to_i
  log.save!
  @response = {'status'=>'disconnection successful'}
  rescue => e
   logger.fatal "#{e}"
   @response = {'status'=>'disconnection failure'}
  end
#TODO: MAKE IT SHOVE ERROR MESSAGES UP YOUR ASS SO SERVER CAN RESEND THIS DATA (AKA EXCEPTIONS)
 end
end
