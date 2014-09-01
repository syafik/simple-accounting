module AllowanceClaimTransactionsHelper
	def get_name_sub_cat(history)
		allowance_claim_transaction_history.try(:allowance).try(:allowance_sub_category).try(:name)
	end
end
