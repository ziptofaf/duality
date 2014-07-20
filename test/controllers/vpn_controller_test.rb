require 'test_helper'

class ProductProcessors::VpnControllerTest < ActionController::TestCase
  test "shouldnt let you see this without being logged in" do
    get :new, :id=>1
    assert_response :redirect
  end

  test "shouldnt let you see this if you use incorrect id" do
	user = User.find_by email: "genius@genius.com"
   	sign_in user
	get :new, :id=>0
	assert_response :redirect
  end
  test "should let you see this if you use correct id" do
        user = User.find_by email: "genius@genius.com"
        sign_in user
	product = Product.where("ProductProcessor_id=?", 1).first
	pp = ProductProcessor.first 
	product.update_attribute :ProductProcessor_id, pp.id 
        get :new, :id=>product.id
        assert_response :success
  end

  test "shouldn't create any accounts!" do
	 user = User.find_by email: "genius@genius.com"
         sign_in user
	 prepare_a_product
	 assert_no_difference('Account.count') do
		post :create, :vpn => { :location => "Hell"}
	 	assert_response :redirect
	 end
  end

  test "shouldn't create any accounts if duration is invalid!" do
         user = User.find_by email: "genius@genius.com"
         sign_in user
         product = prepare_a_product
         assert_no_difference('Account.count') do
                post :create, :vpn => { :location => "russia", :time => 6, :id=> product.id}
                assert_response :redirect
         end
  end

test "should create an account if all data is valid!" do
         user = User.find_by email: "genius@genius.com"
         sign_in user
         product = prepare_a_product
	 server = Server.first
         assert_difference('Account.count') do
                post :create, :vpn => { :location => server.location, :time => 2, :id=> product.id}
                assert_response :redirect 
         end
  end

test "shouldn't create an account if user is too poor" do
	user = User.find_by email: "idiot@idiot.com"
	sign_in user
	product = prepare_a_product
        server = Server.first
	assert_no_difference('Account.count') do
		post :create, :vpn => { :location => server.location, :time => 2, :id=> product.id}
                assert_response :redirect
	end
  end


test "should extend the vpn" do
	prod = prepare_a_product
	acc = prepare_an_account(prod)
	id_reference = acc.id
	user = User.find_by email: "genius@genius.com"
	current_balance = user.balance
        sign_in user
	current_length = acc.expire
	post :extend_account, :extend => {:time => 1, :id => acc.id}
	acc = Account.find(acc.id)
	assert current_length != acc.expire, "VPN wasn't extended!"
	user = User.find_by email: "genius@genius.com"
	assert current_balance != user.balance, "User hasn't paid for vpn extension"
end

test "shouldnt extend the vpn that doesnt belong to a user" do
        prod = prepare_a_product
        acc = prepare_an_account(prod)
        id_reference = acc.id
        user = User.find_by email: "idiot@idiot.com"
	user.update_attribute :balance, 99.99
        sign_in user
        current_length = acc.expire
        post :extend_account, :extend => {:time => 1, :id => acc.id}
        acc = Account.find(acc.id)
        assert current_length == acc.expire, "VPN was extended!"
	user.update_attribute :balance, 0.11 # dunno if its necessary honestly, just a safety measure
end

def prepare_a_product
	product = Product.first
	pp = ProductProcessor.first
	product.update_attribute :ProductProcessor_id, pp.id
	return product
end

def prepare_an_account(prod)
	account = Account.find_by login: "aabbcc"
	user = User.find_by email: "genius@genius.com"
	account.update_attribute :user_id, user.id
	server = Server.where("location = ? and level = ?", "russia", 1).first
	account.update_attribute :server_id, server.id
	account.update_attribute :product_id, prod.id
	return account
end

end
