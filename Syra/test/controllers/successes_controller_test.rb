require 'test_helper'

class SuccessesControllerTest < ActionController::TestCase
  setup do
    @success = successes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:successes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create success" do
    assert_difference('Success.count') do
      post :create, success: { label: @success.label, locked: @success.locked, urlImageUnvalidate: @success.urlImageUnvalidate, urlImageValidate: @success.urlImageValidate, user_id: @success.user_id }
    end

    assert_redirected_to success_path(assigns(:success))
  end

  test "should show success" do
    get :show, id: @success
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @success
    assert_response :success
  end

  test "should update success" do
    patch :update, id: @success, success: { label: @success.label, locked: @success.locked, urlImageUnvalidate: @success.urlImageUnvalidate, urlImageValidate: @success.urlImageValidate, user_id: @success.user_id }
    assert_redirected_to success_path(assigns(:success))
  end

  test "should destroy success" do
    assert_difference('Success.count', -1) do
      delete :destroy, id: @success
    end

    assert_redirected_to successes_path
  end
end
