class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.string :description
      t.integer :value
      t.boolean :is_debit, :default => false

      t.timestamps
    end
  end
end
