class ApiController < ApplicationController
skip_before_action :authorize
skip_before_action :verify_authenticity_token
respond_to :json

  def client_side
    return unless api_params[:email] && api_params[:password] && api_params[:api_key]
   user = User.find_by(email: api_params[:email].downcase)
  if user && user.active>=1 && user.authenticate(api_params[:password]) && api_params[:api_key]=='MsofNLIfkVI4p28028q4'
   @test = Account.joins(:user).joins(:server).where('user_id=?', user.id).select(:login, :password, :ip, :cert_url, :location, 'servers.level')
     else
   return
   end
  return     
  end

  def server_side
  @response = {'status'=>'failure'} and return unless api_params[:email] && api_params[:password] && api_params[:api_key]=='0mfd1INmx86TAzY3U25O' && api_params[:server_id]
   user = Account.find_by login: api_params[:email]
  @response = {'status'=>'failure'} and return unless user && user.server_id==api_params[:server_id].to_i && user.expire>DateTime.current && user.password==api_params[:password]
  @response = {'status'=>'success'}
  end

  def api_params
   params.permit(:email, :password, :api_key, :format, :server_id)
  end

end
