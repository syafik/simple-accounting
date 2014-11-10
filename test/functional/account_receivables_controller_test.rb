require 'test_helper'

class AccountReceivablesControllerTest < ActionController::TestCase
  setup do
    @account_receivable = account_receivables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_receivables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_receivable" do
    assert_difference('AccountReceivable.count') do
      post :create, account_receivable: {  }
    end

    assert_redirected_to account_receivable_path(assigns(:account_receivable))
  end

  test "should show account_receivable" do
    get :show, id: @account_receivable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_receivable
    assert_response :success
  end

  test "should update account_receivable" do
    put :update, id: @account_receivable, account_receivable: {  }
    assert_redirected_to account_receivable_path(assigns(:account_receivable))
  end

  test "should destroy account_receivable" do
    assert_difference('AccountReceivable.count', -1) do
      delete :destroy, id: @account_receivable
    end

    assert_redirected_to account_receivables_path
  end
end
