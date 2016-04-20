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
  #   "reimburs": [
  #     {
  #       "name": "User",
  #       "status": null,
  #       "grade": "A",
  #       "family_id": 1
  #     }
  #   ]
  # }
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
  #   "name": "User",
  #   "status": null,
  #   "grade": "A",
  #   "rj": "Rp. 350.000",
  #   "ri": "Rp. 350.000",
  #   "operasi": "Rp. 25.000.000",
  #   "reimbursement": [
  #     {
  #       "created_at": "2016-04-20T15:02:57+07:00",
  #       "no_kwitasi": "123123",
  #       "rumah_sakit": "Rumah Sakit",
  #       "total_claim": "Rp. 200.000",
  #       "total_approve": "Rp. 200.000",
  #       "status": "<label class=\"btn btn-success btn-xs\">approved</label>",
  #       "reimburs_type": "RJ",
  #       "note": "Deal"
  #     }
  #   ]
  # }
  def show
    @year_insurances = YearInsurance.where(family_id: params[:id] ).by_year(params[:year]).first
  end

end
