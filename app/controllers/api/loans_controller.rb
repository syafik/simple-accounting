class Api::LoansController < ApplicationController
  skip_before_filter :authenticate_user!, :verify_authenticity_token
  before_filter :authenticate_api
  respond_to :json

## Loan List
  def index
    @histories =  current_user_api.borrowers.order("date DESC")
    @sisa =  @histories.sum(&:credit) - @histories.sum(&:debit)
  end

end