require 'test_helper'

class SalarySchedulesControllerTest < ActionController::TestCase
  setup do
    @salary_schedule = salary_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salary_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salary_schedule" do
    assert_difference('SalarySchedule.count') do
      post :create, salary_schedule: { date: @salary_schedule.date }
    end

    assert_redirected_to salary_schedule_path(assigns(:salary_schedule))
  end

  test "should show salary_schedule" do
    get :show, id: @salary_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salary_schedule
    assert_response :success
  end

  test "should update salary_schedule" do
    put :update, id: @salary_schedule, salary_schedule: { date: @salary_schedule.date }
    assert_redirected_to salary_schedule_path(assigns(:salary_schedule))
  end

  test "should destroy salary_schedule" do
    assert_difference('SalarySchedule.count', -1) do
      delete :destroy, id: @salary_schedule
    end

    assert_redirected_to salary_schedules_path
  end
end
