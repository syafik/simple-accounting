class CreateClaimTransactions < ActiveRecord::Migration
  def change
    create_table :claim_transactions do |t|
      t.date :date_submission
      t.date :approval_date
      t.string :upload
      t.boolean :status
      t.text :description
      t.references :allowance

      t.timestamps
    end
    add_index :claim_transactions, :allowance_id
  end
end
