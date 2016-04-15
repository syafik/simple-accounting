class Api::ReimbursementsController < Api::ApiController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ##
  # ::Reimbursement
  # ===Reimbursement
  # method:
  #   GET
  # url:
  #   /api/reimbursements
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  # {
  #   "reimburs":[
  #     {
  #       "name":"User",
  #        "status":null,
  #        "grade":"A"
  #      }]
  #  }
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
