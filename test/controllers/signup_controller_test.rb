require 'test_helper'

class SignupControllerTest < ActionController::TestCase
#no idea how to do anything about thing that doesnt have a controller name due to using match

  test "shouldnt get new without SSL" do
    get :new
    assert_response :redirect
  end


  test "shouldnt create a session without all data" do
    post :create
    assert_response :redirect
  end

end
