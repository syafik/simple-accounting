class AddPaymentToOvertime < ActiveRecord::Migration
  def change
  	add_column :overtimes, :payment, :float
  end
end
