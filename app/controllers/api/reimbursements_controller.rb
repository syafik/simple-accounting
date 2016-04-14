class Api::ReimbursementsController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ## Family List
  # Show Family List
  def index
    @family =Family.where(familyable_id: current_user_api , familyable_type: "User").first
    family_ids = @family.children.map(&:id)
    family_ids << @family.id
    @year_insurances = YearInsurance.where(family_id: family_ids).by_year(params[:year])
  end

  ## List Claim
  # showing list claim of family member
  def show
    @year_insurances = YearInsurance.where(family_id: params[:id] ).by_year(params[:year])
  end

end
