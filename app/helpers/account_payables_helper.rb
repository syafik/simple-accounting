module AccountPayablesHelper
	def debit_account
		debits = []
		AccountPayable.where(parent_id: nil).collect do |p| 
			credit = p.children.sum(&:credit)
		   if p.debit - credit  != 0
		   	debits << ["#{p.title} sisa cicilan #{number_to_currency(p.debit - credit, unit: "Rp.  ") }", p.id]
		   end

	end
	debits
end

end
