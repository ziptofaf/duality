class ProfileController < ApplicationController
  def general
	@user = User.find(session[:user_id])
  end

  def payments
	@payment = Payment.where("user_id = ? AND status != ?", session[:user_id], "pending").order('created_at desc').take(10)
	@purchase = Purchase.where("user_id = ?", session[:user_id]).order('created_at desc').take(10)
  end

  def vpns
	@vpns = Account.joins(:server).where("user_id = ? AND expire > ?", session[:user_id], Time.now).select(:login, :password, :expire, :ip, :location, :active, "accounts.id")
  end
  def change
  	@user = User.find(session[:user_id])
  end
  def update
	@user = User.find(session[:user_id])
	flash.now[:error]="You typed your current password incorrectly!" and render 'change' and return unless @user.authenticate(profile_params[:current_password])
	@user.password = profile_params[:password]
	@user.password_confirmation = profile_params[:password_confirmation]
	if @user.save
		flash.now[:notice]='Your password has been updated' and render 'change'
	else
		flash.now[:error]='Your password has NOT been updated, reasons below' and render 'change'
	end
  end
 
def profile_params
params.require(:profile).permit(:current_password, :password, :password_confirmation)
end

def activity
@user = User.find(session[:user_id])
@logs = User.joins(:account_logs).where('user_id=?', @user.id).select(:kilobytes_sent, :kilobytes_received, :start, :end)
#redirect_to root_path and flash[:error]="You have no VPN accounts to check their activity" and return if @logs.empty?
end

end
