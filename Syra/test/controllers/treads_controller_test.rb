require 'test_helper'

class TreadsControllerTest < ActionController::TestCase
  setup do
    @tread = treads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:treads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tread" do
    assert_difference('Tread.count') do
      post :create, tread: { hobby_id: @tread.hobby_id, subject: @tread.subject, user_id: @tread.user_id }
    end

    assert_redirected_to tread_path(assigns(:tread))
  end

  test "should show tread" do
    get :show, id: @tread
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tread
    assert_response :success
  end

  test "should update tread" do
    patch :update, id: @tread, tread: { hobby_id: @tread.hobby_id, subject: @tread.subject, user_id: @tread.user_id }
    assert_redirected_to tread_path(assigns(:tread))
  end

  test "should destroy tread" do
    assert_difference('Tread.count', -1) do
      delete :destroy, id: @tread
    end

    assert_redirected_to treads_path
  end
end
