class ProductProcessors::VpnController < ApplicationController
include VpnHelper
include ZipHelper
def new
	my_id
	(redirect_to root_path and error_message and return) unless Product.exists?(id: (vpn_params[:id].to_i), ProductProcessor_id: (@@my_id.to_i))
	@product = Product.find(vpn_params[:id])
        @level=parameters_to_level(@product.parameters)
	(redirect_to root_path and error_message and return) if @level==0
		
end


def create
	(flash[:error]="You need to fill all fields before proceeding" and redirect_to store_path and return) unless buy_params[:time] and buy_params[:location]!="" and buy_params[:id]	
	my_id
	(redirect_to root_path and error_message and return) unless Product.exists?(id: buy_params[:id], ProductProcessor_id: (@@my_id.to_i))
	begin
                @product = Product.find(buy_params[:id])
                pool_level = parameters_to_level(@product.parameters)
                server_pool = ServerPool.find(pool_level)
                check_if_correct(buy_params[:time].to_f)
                price = @product.price * buy_params[:time].to_f
                pay(price)
		log_payment(@product.id, price)
		create_account(server_pool, @product.id, buy_params[:time].to_f)
        rescue => e
                redirect_to store_path and flash[:error]= "#{e}" and return
        end
                flash[:notice]="Your account has been created!"
		redirect_to store_path
		 
end

def update
	begin
		@product = can_extend?(vpn_params[:id])
		@account = vpn_params[:id]
		#flash[:account_id] = (vpn_params[:id])
	rescue => e
		redirect_to root_path and return
	end
end

def extend_account
	begin
		redirect_to root_path and error_message and return unless extend_params[:id] and extend_params[:time]
		product = can_extend?(extend_params[:id])
		check_if_correct(extend_params[:time].to_f)
		to_pay = (extend_params[:time].to_f * product.price.to_f).round(2)
		pay(to_pay) 
		log_payment(product.id, to_pay, true)
		extend_this_account(extend_params[:id], extend_params[:time].to_f)
	rescue => e
		redirect_to root_path and flash[:error]="#{e}" and return
	end
		flash[:notice]="Your account has been extended!"
                redirect_to store_path
end

def details
	user = User.find(session[:user_id].to_i)
	redirect_to root_path and return unless Account.exists?(vpn_params[:id])
	@account = Account.where("user_id=? and id=?", user.id, vpn_params[:id].to_i)
	@servers = Server.where("server_pool=?", @account.server_pool)
end

def sendZip
	redirect_to root_path and return unless session[:link]
	system "#{scriptPath} #{@@zipName} #{certUrl(@@server)} #{@@server.certname} #{@@server.ip} #{serverPort(@@server)} #{currentPath} #{packPath}"
	send_file ("#{toSendPath(@@zipName)}")
end




def vpn_params
params.permit(:id)
end

def my_id
@@my_id=ProductProcessor.find_by name: "vpn"
@@my_id=@@my_id.id
end 

def buy_params
 params.require(:vpn).permit(:time, :id, :utf8, :authenticity_token)
end

def extend_params
 params.require(:extend).permit(:time, :id)
end


end
