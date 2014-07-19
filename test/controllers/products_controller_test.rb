require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "shouldnt get index without admin privileges" do
    get :index
    assert_response :redirect
    #assert_not_nil assigns(:products)
  end

  test "shouldnt get new without admin privileges" do
    get :new
    assert_response :redirect
  end

  test "should create product" do
    assert_no_difference('Product.count') do
      post :create, product: { ProductProcessor_id: @product.ProductProcessor_id, description: @product.description, name: @product.name, parameters: @product.parameters, price: @product.price }
    end

    assert_redirected_to login_path
  end

#  test "shouldnt show product without admin privileges" do
#    get :show, id: @product
#    assert_response :redirect
#  end

  test "shouldnt get edit without admin privileges" do
    get :edit, id: @product
    assert_response :redirect
  end

  test "shouldnt update product" do
    patch :update, id: @product, product: { ProductProcessor_id: @product.ProductProcessor_id, description: @product.description, name: @product.name, parameters: @product.parameters, price: @product.price }
    assert_redirected_to login_path
  end

  test "shouldnt destroy product" do
    assert_no_difference('Product.count') do
      delete :destroy, id: @product
    end

    assert_redirected_to login_path
  end
end
