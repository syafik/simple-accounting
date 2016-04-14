module AccountReceivablesHelper # :nodoc:
	def credit_account
		credits = []
		AccountReceivable.where(parent_id: nil).collect do |p|
			debit = p.children.sum(&:debit)
			if p.credit - debit != 0
			credits << ["Sisa cicilan #{p.title} #{number_to_currency(p.credit - debit, unit: "Rp.  ") }", p.id]
			end

		end
		credits
	end

end
