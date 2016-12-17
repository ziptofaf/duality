require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
	test "shouldnt allow to login without all data" do
		post :create, :session => {:email => "empty"}
		assert_response :success 
		assert !session[:user_id]
		assert !session[:expires_at]
	end
	
	test "should allow to login with proper login+pw" do
		post :create, :session => { :email => "genius@genius.com", :password => "secret"}
		assert_response :redirect
		assert session[:user_id]
                assert session[:expires_at]	
	end
end
