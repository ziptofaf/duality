require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get general" do
    get :general
    assert_response :success
  end

  test "should get payments" do
    get :payments
    assert_response :success
  end

  test "should get vpns" do
    get :vpns
    assert_response :success
  end

end
