require 'test_helper'

class LoanPermissionsControllerTest < ActionController::TestCase
  setup do
    @loan_permission = loan_permissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loan_permissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan_permission" do
    assert_difference('LoanPermission.count') do
      post :create, loan_permission: { approval_date: @loan_permission.approval_date, description: @loan_permission.description, message: @loan_permission.message, submission_date: @loan_permission.submission_date, total_loan: @loan_permission.total_loan }
    end

    assert_redirected_to loan_permission_path(assigns(:loan_permission))
  end

  test "should show loan_permission" do
    get :show, id: @loan_permission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan_permission
    assert_response :success
  end

  test "should update loan_permission" do
    put :update, id: @loan_permission, loan_permission: { approval_date: @loan_permission.approval_date, description: @loan_permission.description, message: @loan_permission.message, submission_date: @loan_permission.submission_date, total_loan: @loan_permission.total_loan }
    assert_redirected_to loan_permission_path(assigns(:loan_permission))
  end

  test "should destroy loan_permission" do
    assert_difference('LoanPermission.count', -1) do
      delete :destroy, id: @loan_permission
    end

    assert_redirected_to loan_permissions_path
  end
end
