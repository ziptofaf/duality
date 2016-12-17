require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  setup do
    @server = servers(:one)
  end

  test "shouldnt get index without admin privileges" do
    get :index
    assert_response :redirect
    #assert_not_nil assigns(:servers)
  end

  test "shouldnt get new without admin privileges" do
    get :new
    assert_response :redirect
  end

  test "should NOT create server without admin privileges" do
    assert_no_difference('Server.count') do
      post :create, server: { capacity_current: @server.capacity_current, server_pool_id: 1, cert_url: @server.cert_url, ip: @server.ip, location: @server.location }
    end

    assert_redirected_to login_path
  end

 # test "should show server" do
 #   get :show, id: @server
 #   assert_response :success
 # end

  test "shouldnt get edit without admin priviliges" do
    get :edit, id: @server
    assert_response :redirect
  end

  test "shouldnt update server without admin priviliges" do
    patch :update, id: @server, server: { capacity_current: @server.capacity_current, server_pool: 1, cert_url: @server.cert_url, ip: @server.ip, location: @server.location }
    assert_redirected_to login_path
  end

  test "shouldnt destroy server" do
    assert_no_difference('Server.count') do
      delete :destroy, id: @server
    end

    assert_redirected_to login_path
  end
end
