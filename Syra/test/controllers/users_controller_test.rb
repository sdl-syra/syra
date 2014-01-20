require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { address_id: @user.address_id, biography: @user.biography, email: @user.email, isPremium: @user.isPremium, lastName: @user.lastName, level_id: @user.level_id, money: @user.money, name: @user.name, password: @user.password, success_id: @user.success_id }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { address_id: @user.address_id, biography: @user.biography, email: @user.email, isPremium: @user.isPremium, lastName: @user.lastName, level_id: @user.level_id, money: @user.money, name: @user.name, password: @user.password, success_id: @user.success_id }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
