class SessionsController < ApplicationController
skip_before_action :authorize
force_ssl if: :ssl_configured?
 def new
  if logged_in?
   flash.now[:error] = 'You are already logged in'
   redirect_to root_path
  end
 end

 def create
  sleep 0.07
  reset_session
  user = User.find_by(email: session_params[:email].downcase)
  if user && user.active>=1 && user.authenticate(session_params[:password])
   sign_in user
   redirect_to root_path
  else
   flash.now[:error] = 'Invalid email/password combination'
   render 'new'
  end
 end

 def destroy
  reset_session
  redirect_to root_path
 end 

 def session_params
  params.require(:session).permit(:email, :password)
 end
 
end
