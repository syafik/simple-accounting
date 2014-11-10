module AccountPayablesHelper
	def debit_account
		debits = []
		AccountPayable.where(parent_id: nil).collect do |p| 
			credit = p.children.sum(&:credit)
			debits << ["#{p.title} sisa cicilan Rp.#{p.debit - credit}", p.id] 
		end
		debits
	end


end
