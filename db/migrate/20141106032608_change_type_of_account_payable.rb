class ChangeTypeOfAccountPayable < ActiveRecord::Migration
  def up
   change_column :account_payables, :date, :date
  end

  def down
   change_column :account_payables, :date, :datetime
  end
end
