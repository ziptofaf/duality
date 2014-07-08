class SupportController < ApplicationController
skip_before_action :authorize
require 'securerandom'
  def forgot_password
	
  end

  def password_reset
  	redirect_to root_path and return unless recovery_params[:email] and recovery_params[:answer] and recovery_params[:answer]=="abbzx"
  	RecoveryMailer.send_password_code(recovery_params[:email]).deliver
	flash[:notice]="If entered e-mail adress was correct, you will be sent a message containing information necessary to change your password"
	redirect_to root_path
  end 

  def password_reset_confirm
	redirect_to root_path and flash[:error]="Invalid code" and return unless Recovery.exists?(code: (token_params[:code].to_s)) 
	recovery=Recovery.find_by code: token_params[:code]
	redirect_to root_path and flash[:error]="Invalid code" and return unless recovery.expire>(Time.now) and User.exists? id: (recovery.user_id)
	user = User.find(recovery.user_id)
	pw = SecureRandom.hex(10).to_s
	user.password = pw
	user.password_confirmation = pw
	redirect_to root_path and error_message and return unless user.save
	RecoveryMailer.send_password(user.email, pw).deliver
	recoveries = Recovery.where("user_id = ? and expire > ?", user.id, Time.now)
	recoveries.each do |recovery|
		recovery.expire=Time.now-180.minutes
		logger[:error]="Recovery #{recovery.id} was not purged!" unless recovery.save
	end
	render 'confirm'
  end

  def recovery_params
	params.require(:recovery).permit(:email, :answer)
  end

  def token_params
	params.permit (:code)
  end

end
