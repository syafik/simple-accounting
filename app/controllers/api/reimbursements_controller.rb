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
  #       "name":"admin",
  #       "status":null,
  #       "grade":"A"
  #      }
  #     ]
  #  }
  def index
    @family =Family.where(familyable_id: current_user_api , familyable_type: "User").first
    family_ids = @family.children.map(&:id)
    family_ids << @family.id
    @year_insurances = YearInsurance.where(family_id: family_ids).by_year(params[:year])
  end

  ##
  # ::Reimbursement List Claim
  # ===Reimbursement List Claim
  # method:
  #   GET
  # url:
  #   /api/reimbursements/:family_id
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  # {
  #   "name": "admin",
  #   "status": null,
  #   "grade": "A",
  #   "rj": "Rp. 250.000",
  #   "ri": "Rp. 250.000",
  #   "operasi": "Rp. 25.000.000"
  # }
  def show
    @year_insurances = YearInsurance.where(family_id: params[:id] ).by_year(params[:year]).first
  end

end
