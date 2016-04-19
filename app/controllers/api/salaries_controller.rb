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
  #   "gaji_pokok":"Rp. 2.000.000,00",
  #   "gaji_lembur":"Rp. 0,00",
  #   "etc":"Rp. 200.000,00",
  #   "jamsostek":"Rp. 100.000,00",
  #   "potongan":"Rp. 100.000,00",
  #   "thp":"Rp. 200.000,00",
  #   "total":2100000.0,
  #   "dikirim":"11-April-2016"
  # }
  def index
    salaries = current_user_api.salary_histories.activate.first
    @salary = salaries.salaries.this_month.first
    @total_pendapatan = @salary.salary_history.payment +  @salary.total_overtime_payment + @salary.jamsostek
    @total_potongan   = 0
    @total_penerimaan = @total_pendapatan - @total_potongan
  end

end
