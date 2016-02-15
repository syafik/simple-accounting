require 'test_helper'

class GradesControllerTest < ActionController::TestCase
  setup do
    @grade = grades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grade" do
    assert_difference('Grade.count') do
      post :create, grade: { end_salary: @grade.end_salary, is_active: @grade.is_active, name: @grade.name, operasi: @grade.operasi, rb_caesar: @grade.rb_caesar, rb_normal: @grade.rb_normal, ri: @grade.ri, rj: @grade.rj, start_salary: @grade.start_salary }
    end

    assert_redirected_to grade_path(assigns(:grade))
  end

  test "should show grade" do
    get :show, id: @grade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grade
    assert_response :success
  end

  test "should update grade" do
    put :update, id: @grade, grade: { end_salary: @grade.end_salary, is_active: @grade.is_active, name: @grade.name, operasi: @grade.operasi, rb_caesar: @grade.rb_caesar, rb_normal: @grade.rb_normal, ri: @grade.ri, rj: @grade.rj, start_salary: @grade.start_salary }
    assert_redirected_to grade_path(assigns(:grade))
  end

  test "should destroy grade" do
    assert_difference('Grade.count', -1) do
      delete :destroy, id: @grade
    end

    assert_redirected_to grades_path
  end
end
