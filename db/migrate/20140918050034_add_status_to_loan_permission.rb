class AddStatusToLoanPermission < ActiveRecord::Migration
  def change
  	add_column :loan_permissions, :status, :integer
  end
end
