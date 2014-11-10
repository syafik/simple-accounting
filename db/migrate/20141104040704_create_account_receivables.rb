class CreateAccountReceivables < ActiveRecord::Migration
  def change
    create_table :account_receivables do |t|
      t.string :title
      t.integer :debit
      t.integer :credit
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
