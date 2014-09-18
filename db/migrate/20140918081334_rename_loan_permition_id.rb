class RenameLoanPermitionId < ActiveRecord::Migration
  def change
  	rename_column :loan_payments, :LoanPermission_id, :loan_permission_id
  end
end
