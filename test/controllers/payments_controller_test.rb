require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  test "shouldnt get show without admin rights" do
    get :show
    assert_response :redirect
  end

end
