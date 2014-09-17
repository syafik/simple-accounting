require 'test_helper'

class AbsentPermissionsControllerTest < ActionController::TestCase
  setup do
    @absent_permission = absent_permissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:absent_permissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create absent_permission" do
    assert_difference('AbsentPermission.count') do
      post :create, absent_permission: { approval_date: @absent_permission.approval_date, category: @absent_permission.category, date_submission: @absent_permission.date_submission, description: @absent_permission.description, long: @absent_permission.long, status: @absent_permission.status }
    end

    assert_redirected_to absent_permission_path(assigns(:absent_permission))
  end

  test "should show absent_permission" do
    get :show, id: @absent_permission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @absent_permission
    assert_response :success
  end

  test "should update absent_permission" do
    put :update, id: @absent_permission, absent_permission: { approval_date: @absent_permission.approval_date, category: @absent_permission.category, date_submission: @absent_permission.date_submission, description: @absent_permission.description, long: @absent_permission.long, status: @absent_permission.status }
    assert_redirected_to absent_permission_path(assigns(:absent_permission))
  end

  test "should destroy absent_permission" do
    assert_difference('AbsentPermission.count', -1) do
      delete :destroy, id: @absent_permission
    end

    assert_redirected_to absent_permissions_path
  end
end
