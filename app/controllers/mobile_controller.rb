class MobileController < ApplicationController
  include MobileHelper
  include ZipHelper
  def view
    @mobileExists = userHasMobileAccount?(session[:user_id])
    @eligibleToHave = userHasAccount?(session[:user_id])
    #@mobileAccount = findMobileAccount(session[:user_id]) if @mobileExists
  end

  def add
    error_message and redirect_to root_path and return if userHasMobileAccount?(session[:user_id]) or !userHasAccount?(session[:user_id])
    mainAccount = Account.find_by user_id: session[:user_id]
    if generateMobileAccount(session[:user_id], mainAccount.id)
      flash[:notice] = "Your account has been created!" and redirect_to mobile_view_path and return
    else
      error_message and redirect_to mobile_view_path and return
    end
  end

  def check
    error_message and redirect_to root_path and return unless userHasMobileAccount?(session[:user_id])
    @account = findMobileAccount(session[:user_id])

    servers = Server.where("server_pool_id=?", @account.account.server_pool_id).group_by {|u| u.location}
    @servers = Array.new
    servers.each do |server|
      @servers << "#{server[0]}"
    end

  end

end
