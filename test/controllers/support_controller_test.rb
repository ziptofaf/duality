require 'test_helper'

class SupportControllerTest < ActionController::TestCase
  test "should get password_reset" do
    get :password_reset
    assert_response :success
  end

  test "should get password_reset_confirm" do
    get :password_reset_confirm
    assert_response :success
  end

end
