class Api::SalariesController < Api::ApiController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ##
  # ::Salaries
  # ===salaries
  # method:
  #   GET
  # url:
  #   /api/salaries
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  # {
  #   "gaji_pokok": "Rp. 2.000.000,00",
  #   "gaji_lembur": "Rp. 0,00",
  #   "etc": null,
  #   "jamsostek": "Rp. 0,00",
  #   "potongan": "-",
  #   "thp": "Rp. 2.000.000,00",
  #   "total": "Rp. 2.000.000,00",
  #   "dikirim": "21-April-2016"
  # }
  # * failed
  # {
  #   "message":"Salary data not found"
  # }
  def index
    salaries = current_user_api.salary_histories.activate.first
    if salaries.present?
      @salary = salaries.salaries.this_month.first
      @total_pendapatan = @salary.salary_history.payment +  @salary.total_overtime_payment + @salary.jamsostek
      @total_potongan   = 0
      @total_penerimaan = @total_pendapatan - @total_potongan
    else
      render :status => 404, :json => {:message => "Salary data not found"}
    end
  end

end
