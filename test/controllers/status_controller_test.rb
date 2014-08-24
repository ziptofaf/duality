require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  test "shouldnt get server without being logged in" do
    get :server
    assert_response :redirect
  end

end
