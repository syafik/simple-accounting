class CreateTransactionSummaries < ActiveRecord::Migration
  def change
    create_table :transaction_summaries do |t|
      t.string :name
      t.integer :summary_month
      t.integer :summary_year
      t.integer :debit, :limit => 8
      t.integer :credit, :limit => 8
      t.integer :total, :limit => 8
      t.text :description

      t.timestamps
    end
  end
end
