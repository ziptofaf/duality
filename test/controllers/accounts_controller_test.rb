require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:one)
  end

  test "shouldnt get index without admin privileges" do
    get :index
    assert_response :redirect
    #assert_not_nil assigns(:accounts)
  end

  test "shouldnt get new without admin privileges" do
    get :new
    assert_response :redirect
  end

  test "shouldnt create account without admin privileges" do
    assert_no_difference('Account.count') do
      post :create, account: { expire: @account.expire, login: @account.login, password: @account.password, server_pool_id: 1, user_id: @account.user_id }
    end

    assert_redirected_to login_path
  end

#  test "shouldnt show account without admin privileges" do
#    get :show, id: @account
#    assert_response :redirect
#  end

  test "shouldnt get edit without admin privileges" do
    get :edit, id: @account
    assert_response :redirect
  end

  test "shouldnt update account without admin priviliges" do
    patch :update, id: @account, account: { expire: @account.expire, login: @account.login, password: @account.password, server_pool_id: 1, user_id: @account.user_id }
    assert_redirected_to login_path
  end

  test "should destroy account" do
    assert_no_difference('Account.count') do
      delete :destroy, id: @account
    end

    assert_redirected_to login_path
  end
end
