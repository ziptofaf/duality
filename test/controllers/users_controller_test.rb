require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "shouldnt get index without admin privileges" do
    get :index
    assert_response :redirect
    #assert_not_nil assigns(:users)
  end

  test "shouldnt get new without admin privileges" do
    get :new
    assert_response :redirect
  end

  test "shouldnt create user without admin privileges" do
    assert_no_difference('User.count') do
      post :create, user: { active: @user.active, email: @user.email, password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to login_path
  end

#  test "shouldnt show user without admin privileges" do
#    get :show, id: @user
#    assert_response :redirect
#  end

  test "shouldnt get edit without admin privileges" do
    get :edit, id: @user
    assert_response :redirect
  end

  test "shouldnt update user without admin privileges" do
    patch :update, id: @user, user: { active: @user.active, email: @user.email, password: 'secret', password_confirmation: 'secret' }
    assert_redirected_to login_path
  end

  test "shouldnt destroy user without admin privileges" do
    assert_no_difference('User.count') do
      delete :destroy, id: @user
    end

    assert_redirected_to login_path
  end
end
