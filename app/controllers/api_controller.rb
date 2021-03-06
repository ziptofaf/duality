class ApiController < ApplicationController
include SpecialAccountHelper
include DcLogHelper
include ApiHelper
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

  def server_side
  @response = {:status=>'failure'} and return unless api_params[:login] && api_params[:password] && api_params[:api_key]=='0mfd1INmx86TAzY3U25O' && api_params[:server_id]
  if api_params[:login][0]=='@'
    login = api_params[:login]
    password = api_params[:password]
    server = Server.find(api_params[:server_id])
    account = findParentAccount(login)
    @response = {:status=>'failure'} and return if account.nil?
    @response = {:status=>'failure'} and return unless server && account.server_pool_id>=server.server_pool_id && account.expire>Time.now &&
                                                        authorizeSubaccount(login, password) && account.active<=4
    @response = {:status=>'success'}
  else
    server = Server.find(api_params[:server_id])
    account = Account.find_by login: api_params[:login]
    @response = {:status=>'failure'} and return unless account && server && account.server_pool_id>=server.server_pool_id && account.expire>Time.now &&
                                                        account.password==api_params[:password] && account.active<=4
    @response = {:status=>'success'}
  end

  end

  def connect
    @response = {:status=>'connection failure'} and return unless api_params[:login] && api_params[:api_key]=='0mfd1INmx86TAzY3U25O' && api_params[:server_id]
    if api_params[:login][0]=='@'
        account = findParentAccount(api_params[:login])
        @response = {:status=>'connection failure'} and return if account.nil?
    else
      account = Account.find_by login: api_params[:login]
    end
    server = Server.find(api_params[:server_id])
   begin
    account.active+=1
    account.save!
    server.capacity_current+=1
    server.save!
    @response= {:status=>'connection success'}
  rescue => e
    logger.fatal "#{e}"
    @response = {:status=>'connection failure'}
   end
  end

  def install

    @response = {:id=>-1, :status => 'failure'}
    return unless api_params[:api_key]=='0mfd1INmx86TAzY3U25O'
    remoteip = request.remote_ip
    return unless Server.exists?(:ip => remoteip)
    server = Server.find_by ip: remoteip
    result = server.id
    @response = {:id=>result, :status => 'success'}
  end

  def check_ip
    message = readClientMessage
   @response = {:ip=> request.remote_ip, :message => message.text, :link=>message.url}
  end

  def api_params
   params.permit(:email, :login, :password, :api_key, :format, :server_id)
  end

  def logs_params
   params.permit(:username, :kilobytes_sent, :kilobytes_received, :remote_ip, :api_key, :session_start, :session_end, :server_id, :format)

  end

 def disconnect
  @response = {:status=>'disconnection failure'} and return unless logs_params[:username] && logs_params[:kilobytes_sent] && logs_params[:kilobytes_received] && logs_params[:server_id] &&
                                                              logs_params[:api_key] && logs_params[:session_start]  && logs_params[:session_end] && logs_params[:remote_ip]
  @response = {:status=>'disconnection failure'} and return unless logs_params[:api_key]=='0mfd1INmx86TAzY3U25O'
  @response = {:status=>'disconnection failure'} and logger.fatal "VPN with that username (#{logs_params[:username]}) SHOULDN'T EXIST. Security breach?" and return unless Account.exists?(:login => logs_params[:username]) or SpecialAccount.exists?(:login => logs_params[:username])
  begin
    if logs_params[:username][0]=='@'
      account = findParentAccount(logs_params[:username])
      @response = {:status=>'disconnection failure'} and return if account.nil?
    else
      account = Account.find_by login: logs_params[:username]
    end
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
   log.start = logs_params[:session_start].to_datetime
   log.end = logs_params[:session_end].to_datetime
   log.save!
   @response = {:status=>'disconnection successful'}
  rescue => e
   logger.fatal "#{e}"
   @response = {:status=>'disconnection failure'}
  end
#TODO: MAKE IT SHOVE ERROR MESSAGES UP YOUR ASS SO SERVER CAN RESEND THIS DATA (AKA EXCEPTIONS)
 end
end
