class AddTotalDayToReimbursement < ActiveRecord::Migration
  def change
    add_column :reimbursements, :total_day, :integer
  end
end
