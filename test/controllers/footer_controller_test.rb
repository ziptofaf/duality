require 'test_helper'

class FooterControllerTest < ActionController::TestCase
  test "should get what_is_vpn" do
    get :what_is_vpn
    assert_response :success
  end

  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

  test "should get vpn_vs_proxy" do
    get :vpn_vs_proxy
    assert_response :success
  end

  test "should get legals" do
    get :legals
    assert_response :success
  end

end
