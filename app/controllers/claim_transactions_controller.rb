
class ClaimTransactionsController < ApplicationController
	def new
		@claim_transaction = ClaimTransactions.new
	end


end
