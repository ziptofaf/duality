require 'test_helper'

class SupportControllerTest < ActionController::TestCase

  test "should show the forgot password" do
	get :forgot_password
	assert_response :success
  end

  test "should get redirected without a PROPER token - password reset" do
    post :password_reset, :recovery => { :email => "foooooo"}
    assert_response :redirect
  end

  test "should NOT get redirected with a PROPER answer token - password reset" do
    post :password_reset, :recovery => { :email => "foooooo", :answer=> "abbzx"}
    assert_redirected_to root_path
  end

  test "should get redirected without a token - password_reset_confirm" do
    get :password_reset_confirm
    assert_response :redirect
  end

end
