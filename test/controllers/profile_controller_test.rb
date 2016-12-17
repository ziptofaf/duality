require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should fail to get general cuz of no session" do
    get :general
    assert_response :redirect
  end

  test "should fail to get payments cuz of no session" do
    get :payments
    assert_response :redirect
  end

  test "should fail to get vpns cuz of no session" do
    get :vpns
    assert_response :redirect
  end

end
