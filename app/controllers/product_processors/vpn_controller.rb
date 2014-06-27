class ProductProcessors::VpnController < ApplicationController
include VpnHelper
def new
	my_id
	(redirect_to root_path and error_message and return) unless Product.exists?(id: (vpn_params[:id].to_i), ProductProcessor_id: (@@my_id.to_i))
	@product = Product.find(vpn_params[:id])
        @level=parameters_to_level(@product.parameters)
	(redirect_to root_path and error_message and return) if @level==0
	@list = Server.where("level=?", @level).select(:location).group("location")	
	@locations = Array.new	
	@list.each do |entry|
	@locations << entry.location
	end 
	
end


def create
	(flash[:error]="You need to fill all fields before proceeding" and redirect_to store_path and return) unless buy_params[:time] and buy_params[:location]!="" and buy_params[:id]	
	my_id
	(redirect_to root_path and error_message and return) unless Product.exists?(id: buy_params[:id], ProductProcessor_id: (@@my_id.to_i))
	begin
                @product = Product.find(buy_params[:id])
                level = parameters_to_level(@product.parameters)
                server = find_a_server(buy_params[:location], level)
                check_if_correct(buy_params[:time].to_f)
                price = @product.price * buy_params[:time].to_f
                pay(price)
		log_payment(@product.id, price)
		create_account(server, @product.id, buy_params[:time].to_f)
        rescue => e
                redirect_to store_path and flash[:error]= "#{e}" and return
        end
                flash[:notice]="Your account has been created!"
                redirect_to root_path	
end

def update
end

def vpn_params
params.permit(:id)
end

def my_id
@@my_id=ProductProcessor.find_by name: "vpn"
@@my_id=@@my_id.id
end 

def buy_params
 params.require(:vpn).permit(:time, :location, :id)
end


end
