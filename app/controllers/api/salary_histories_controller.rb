
class Api::SalaryHistoriesController < Api::ApiController
  respond_to :json

  ##
  # ::Salary_histories
  # ===salarie_histories
  # method:
  #   GET
  # url:
  #   /api/salary_histories
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  # {
  #   "salay_histories": [
  #     {
  #       "tanggal":"2016-04-11",
  #       "gaji":"Rp. 2.000.000,00"
  #     }
  #   ]
  # }
  def index
    @salary_histories = SalaryHistory.where(user_id: current_user_api.id).order("created_at DESC")
  end

end
