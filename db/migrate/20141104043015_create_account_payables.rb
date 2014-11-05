class CreateAccountPayables < ActiveRecord::Migration
  def change
    create_table :account_payables do |t|
      t.string :time
      t.integer :debit, :limit => 8
      t.integer :credit, :limit => 8
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
