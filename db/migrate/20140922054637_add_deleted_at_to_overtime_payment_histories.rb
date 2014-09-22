class AddDeletedAtToOvertimePaymentHistories < ActiveRecord::Migration
  def change
    add_column :overtime_payment_histories, :deleted_at, :datetime
    add_index :overtime_payment_histories, :deleted_at
  end
end
