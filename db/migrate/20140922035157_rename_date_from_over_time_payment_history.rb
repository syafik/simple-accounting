class RenameDateFromOverTimePaymentHistory < ActiveRecord::Migration
  def change
  	rename_column :overtime_payment_histories, :date, :applicable_date
  end
end
