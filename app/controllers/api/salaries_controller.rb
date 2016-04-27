class Api::SalariesController < Api::ApiController
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
  #   "etc": "",
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
      @salary = salaries.salaries.last
      @total_pendapatan = @salary.salary_history.payment +  @salary.total_overtime_payment + @salary.jamsostek +@salary.transport + @salary.etc.to_f rescue 0
      @total_potongan   = @salary.potongan
      if salaries.allowed_jamsostek && salaries.participate_jamsostek
        @total_potongan += @salary.jamsostek
      end
      @total_penerimaan = @total_pendapatan - @total_potongan
    else
      render :status => 404, :json => {:message => "Salary data not found"}
    end
  end

end
