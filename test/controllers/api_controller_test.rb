require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get client_side" do
    post :client_side, :format=>'json'
    assert_response :success
  end

  test "should get server_side" do
    post :server_side, :format=>'json'
    assert_response :success
  end

 test "Should check your IP" do
   get :check_ip, :format=>'json'
   assert_response :success
 end
end
