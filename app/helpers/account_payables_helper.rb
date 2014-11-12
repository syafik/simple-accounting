module AccountPayablesHelper
	def debit_account
		debits = []
		AccountPayable.where(parent_id: nil).collect do |p| 
			credit = p.children.sum(&:credit)
		   if p.debit - credit  != 0
		   	debits << ["#{p.title} sisa cicilan Rp.#{p.debit - credit}", p.id]
		   end

	end
	debits
end

end
