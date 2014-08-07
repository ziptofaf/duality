require 'test_helper'

class ConnectionControllerTest < ActionController::TestCase
  test "should get walkthrough_pc" do
    get :walkthrough_pc
    assert_response :success
  end

  test "should get walkthrough_mac" do
    get :walkthrough_mac
    assert_response :success
  end

  test "should get walkthrough_linux" do
    get :walkthrough_linux
    assert_response :success
  end

end
