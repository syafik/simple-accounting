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
#   {
#     "sisa": 0,
#     "histories": []
#   }
  def index
    @histories =  current_user_api.borrowers.order("date DESC")
    @sisa =  @histories.sum(&:credit) - @histories.sum(&:debit)
  end

end
