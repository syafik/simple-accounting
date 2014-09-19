class AddPaymentDate < ActiveRecord::Migration
  def change
  	add_column :loan_payments, :payment_date, :date
  end
end
