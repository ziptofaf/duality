require 'test_helper'

class MobileControllerTest < ActionController::TestCase
  test "shouldnt reach add without logging in" do
    get :view
    assert_response :redirect
  end

  test "shouldnt get check without redirect" do
    get :check
    assert_response :redirect
  end

end
