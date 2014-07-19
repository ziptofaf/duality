require 'test_helper'

class WalletControllerTest < ActionController::TestCase
  test "should require log-in - add_funds" do
    get :add_funds
    assert_response :redirect
  end

  test "should require log-in - check_history" do
    get :check_history
    assert_response :redirect
  end

end
