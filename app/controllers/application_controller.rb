class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :authorize

  protected
  def authorize
   unless logged_in?
        redirect_to login_url, notice: "Please log in to access that resource"
   end
  end

 def admin_authorize
   user=User.find(session[:user_id])
   unless user.active==2
      flash[:error]="Resource not found"
      redirect_to root_path
   end
 end

  def ssl_configured?
    !Rails.env.development? and !Rails.env.test?
  end
end
