require 'test_helper'

class WalletControllerTest < ActionController::TestCase
  test "should get add_funds" do
    get :add_funds
    assert_response :success
  end

  test "should get check_history" do
    get :check_history
    assert_response :success
  end

end
