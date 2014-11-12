module AccountReceivablesHelper
	def credit_account
		credits = []
		AccountReceivable.where(parent_id: nil).collect do |p|
			debit = p.children.sum(&:debit)
			if p.credit - p.debit != 0
			credits << ["#{p.title} sisa cicilan Rp.#{p.credit - debit}, p.id"]
			end
		end
		credits
	end
end
