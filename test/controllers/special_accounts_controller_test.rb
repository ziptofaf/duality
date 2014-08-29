require 'test_helper'

class SpecialAccountsControllerTest < ActionController::TestCase
  setup do
    @special_account = special_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :redirect
    
  end

  test "shouldnt get new" do
    get :new
    assert_response :redirect
  end

  test "shouldnt create special_account" do
    assert_no_difference('SpecialAccount.count') do
      post :create, special_account: { account_id: @special_account.account_id, login: @special_account.login, password: @special_account.password }
    end
  end

  test "shouldnt show special_account" do
    get :show, id: @special_account
    assert_response :redirect
  end

  test "shouldnt get edit" do
    get :edit, id: @special_account
    assert_response :redirect
  end


  test "should destroy special_account" do
    assert_no_difference('SpecialAccount.count', -1) do
      delete :destroy, id: @special_account
    end

  end
end
