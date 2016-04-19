class Api::LoansController < Api::ApiController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

  ##
  # ::Loan
  # ===Loans
  # method:
  #   GET
  # url:
  #   /api/loans
  # header:
  #   content-type: application/json
  #   authorization:Token token= authtentication_token
  # response:
  # * success
  # {
  #   "sisa": 13000000,
  #   "histories": [
  #     {
  #       "bayar": null,
  #       "borrower_id": 1,
  #       "borrower_type": "User",
  #       "created_at": "2016-04-19T13:12:14+07:00",
  #       "credit": 15000000,
  #       "date": "2016-04-19",
  #       "debit": 0,
  #       "description": "Pinjam Uang",
  #       "id": 1,
  #       "parent_id": null,
  #       "time": null,
  #       "title": "Pinjam",
  #       "updated_at": "2016-04-19T13:12:14+07:00"
  #     },
  #     {
  #       "bayar": null,
  #       "borrower_id": 1,
  #       "borrower_type": "User",
  #       "created_at": "2016-04-19T13:12:37+07:00",
  #       "credit": 0,
  #       "date": "2016-04-19",
  #       "debit": 2000000,
  #       "description": "Bayar",
  #       "id": 2,
  #       "parent_id": 1,
  #       "time": null,
  #       "title": "Bayar",
  #       "updated_at": "2016-04-19T13:12:37+07:00"
  #     }
  #   ]
  # }
  def index
    @histories =  current_user_api.borrowers.order("date DESC")
    @sisa =  @histories.sum(&:credit) - @histories.sum(&:debit)
  end

end
