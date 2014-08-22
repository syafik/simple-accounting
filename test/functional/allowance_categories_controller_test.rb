require 'test_helper'

class AllowanceCategoriesControllerTest < ActionController::TestCase
  setup do
    @allowance_category = allowance_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allowance_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allowance_category" do
    assert_difference('AllowanceCategory.count') do
      post :create, allowance_category: {  }
    end

    assert_redirected_to allowance_category_path(assigns(:allowance_category))
  end

  test "should show allowance_category" do
    get :show, id: @allowance_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allowance_category
    assert_response :success
  end

  test "should update allowance_category" do
    put :update, id: @allowance_category, allowance_category: {  }
    assert_redirected_to allowance_category_path(assigns(:allowance_category))
  end

  test "should destroy allowance_category" do
    assert_difference('AllowanceCategory.count', -1) do
      delete :destroy, id: @allowance_category
    end

    assert_redirected_to allowance_categories_path
  end
end
