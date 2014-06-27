class SignupController < ApplicationController
include SignupHelper
skip_before_action :authorize
before_action :already_registered
force_ssl if: :ssl_configured?
  def new
    sleep 0.07
    @user = User.new
    @craptcha = craptcha
  end

  def create
     @craptcha= craptcha #otherwise craptcha wont reappear after render!
     sleep 0.07
    redirect_to root_path and flash[:error]='Invalid answer to security question!' and return unless user_params[:craptcha]==craptcha_answer 
     @user = User.new(user_params.merge(:active=>1, :balance=>0.00).except(:craptcha))
   if @user.save
     redirect_to root_path, notice: 'Registration was succesful, you can log in now.'
   else
     render action: 'new'
   end    
  end

  private 
  def user_params
      params.require(:signup).permit(:email, :password, :password_confirmation, :craptcha)
  end
end

 def already_registered
  unless logged_in?
  else 
   flash.notice="You are already registered!"
   redirect_to root_path
  end
 end
