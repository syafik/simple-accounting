require 'test_helper'

class ReimbursementsControllerTest < ActionController::TestCase
  setup do
    @reimbursement = reimbursements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reimbursements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reimbursement" do
    assert_difference('Reimbursement.count') do
      post :create, reimbursement: { no_kwitasi: @reimbursement.no_kwitasi, notes: @reimbursement.notes, reimbursement_type: @reimbursement.reimbursement_type, rumah_sakit: @reimbursement.rumah_sakit, status: @reimbursement.status, total_claim: @reimbursement.total_claim, user_id: @reimbursement.user_id, year_insurance_id: @reimbursement.year_insurance_id }
    end

    assert_redirected_to reimbursement_path(assigns(:reimbursement))
  end

  test "should show reimbursement" do
    get :show, id: @reimbursement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reimbursement
    assert_response :success
  end

  test "should update reimbursement" do
    put :update, id: @reimbursement, reimbursement: { no_kwitasi: @reimbursement.no_kwitasi, notes: @reimbursement.notes, reimbursement_type: @reimbursement.reimbursement_type, rumah_sakit: @reimbursement.rumah_sakit, status: @reimbursement.status, total_claim: @reimbursement.total_claim, user_id: @reimbursement.user_id, year_insurance_id: @reimbursement.year_insurance_id }
    assert_redirected_to reimbursement_path(assigns(:reimbursement))
  end

  test "should destroy reimbursement" do
    assert_difference('Reimbursement.count', -1) do
      delete :destroy, id: @reimbursement
    end

    assert_redirected_to reimbursements_path
  end
end
