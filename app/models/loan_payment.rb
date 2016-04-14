class LoanPayment < ActiveRecord::Base  # :nodoc:
	belongs_to :loan_permission
	attr_accessible :approval_date, :description, :message, :submission_date, :total_payment, :loan_permission_id, :status, :payment_date

	def self.get_paid(loan_permission_id, total_payment)
		paid = LoanPayment.where(:loan_permission_id => loan_permission_id, :status => 3).sum(:total_payment)
		total = paid + total_payment
		return total
	end

	def self.get_residue(loan_permission_id)
		loan_permission = LoanPermission.find(loan_permission_id)
		total_paid = LoanPayment.where(:loan_permission_id => loan_permission_id, :status => 1).sum(:total_payment)
		residue = loan_permission.total_loan - total_paid
		return residue
	end
end
