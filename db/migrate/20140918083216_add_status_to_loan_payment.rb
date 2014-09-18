class AddStatusToLoanPayment < ActiveRecord::Migration
  def change
  	add_column :loan_payments, :status, :integer
  end
end
