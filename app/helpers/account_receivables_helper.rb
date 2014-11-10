module AccountReceivablesHelper
	def credit_account
		credits = []
		AccountReceivable.where(parent_id: nil).collect do |p|
			debit = p.children.sum(&:debit)
			credits << ["#{p.title} sisa cicilan Rp.#{p.credit - debit}, p.id"]
		end
		credits
	end
end
