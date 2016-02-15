class AddTotalApprovedToReimbursement < ActiveRecord::Migration
  def change
    add_column :reimbursements, :total_approve, :integer
  end
end
