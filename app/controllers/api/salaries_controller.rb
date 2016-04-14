class Api::SalariesController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

## Salary List
  def index
    salaries = current_user_api.salary_histories.activate.first
    @salary = salaries.salaries.this_month.first
    @total_pendapatan = @salary.salary_history.payment +  @salary.total_overtime_payment + @salary.jamsostek
    @total_potongan   = 0
    @total_penerimaan = @total_pendapatan - @total_potongan
  end

end
