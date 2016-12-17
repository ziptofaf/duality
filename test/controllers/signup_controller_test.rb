require 'test_helper'

class SignupControllerTest < ActionController::TestCase
#no idea how to do anything about thing that doesnt have a controller name due to using match

  test "shouldn get new" do
    get :new
    assert_response :success
  end


  test "shouldnt create a session without all data" do
    post :create, :signup => {:email => "null"}
    assert_response :redirect
    assert !flash[:error].empty?
  end

end
