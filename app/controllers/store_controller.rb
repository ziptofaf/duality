class StoreController < ApplicationController
skip_before_action :authorize
  def index
   @products=Product.all
   @controllers = ProductProcessor.where("usable = ?", 1)
  end

  def view
   (redirect_to store_path and flash[:error]="Product with this ID doesn't exist" and return) unless Product.exists?(:id => (store_params[:id].to_i)) 
   @product = Product.find(store_params[:id])
   @controller = ProductProcessor.find(@product.ProductProcessor_id)
   (redirect_to store_path and flash[:error]="Product with this ID doesn't exist" and return) unless @controller.usable==1 
   @url="/product_processors/{change_me}_new/{change_me_too}"
   @url["{change_me}"]=@controller.name.to_s
   @url["{change_me_too}"]=@product.id.to_s
  end

  def store_params
   params.permit(:id)
  end

end
