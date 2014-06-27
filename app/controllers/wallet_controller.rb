class WalletController < ApplicationController
force_ssl if: :ssl_configured?
  def add_funds
   cached_search_result
   @array = @@processors

  end

  def create
   cached_search_result
   unless wallet_params[:amount] and wallet_params[:payment_method]
    flash[:notice]="You need to choose the amount and payment method before proceeding."
    redirect_to wallet_add_funds_path
    return
   else
     amount = case wallet_params[:amount]
      when "$1" then 1.00
      when "$5" then 5.00
      when "$10" then 10.00
      when "$25" then 25.00
      when "$50" then 50.00
      when "custom" then wallet_params[:val].split(',').join('.').to_f.round(2)
      else "invalid"
     end
     flash[:error]="Entered value should be between 0.1 and 999$" and redirect_to wallet_add_funds_path and return if amount<0 or amount>999 
    (flash[:error]="You need to choose the amount and payment method before proceeding." and redirect_to wallet_add_funds_path and return) if (amount==0.00 or amount=='invalid' or !(@@processors.include?(wallet_params[:payment_method])))
     url='/processors/{chosen}/'
     url["{chosen}"]=wallet_params[:payment_method]
     flash[:amount]=amount
     flash[:type]=wallet_params[:payment_method]
     redirect_to url
   end
  end

  def check_history
  @received_funds = Payment.where('user_id = ? AND status = ? OR status = ?', session[:user_id], "complete", "cancelled")  
  end
protected
  def wallet_params
   params.require(:wallet).permit(:amount, :payment_method, :val)
  end
  
  def cached_search_result
   unless defined? @@processors
    payment_methods=Processor.where("usable = ?", 1)
    @@processors = Array.new
    payment_methods.each do |payment|
    @@processors<<payment.name 
   end 
   @@processors
   else
   @@processors 
  end
  end
end

