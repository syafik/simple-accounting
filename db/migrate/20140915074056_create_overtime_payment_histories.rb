class CreateOvertimePaymentHistories < ActiveRecord::Migration
  def change
    create_table :overtime_payment_histories do |t|
      t.date :date
      t.float :day_payment
      t.float :night_payment
      t.date :date
      t.boolean :activate
      t.references :user

      t.timestamps
    end
    add_index :overtime_payment_histories, :user_id
  end
end
