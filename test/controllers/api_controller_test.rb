require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get client_side" do
    get :client_side
    assert_response :success
  end

  test "should get server_side" do
    get :server_side
    assert_response :success
  end

end
