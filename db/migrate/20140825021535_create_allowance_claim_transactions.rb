class CreateAllowanceClaimTransactions < ActiveRecord::Migration
  def change
    create_table :allowance_claim_transactions do |t|
      t.date :date_submission
      t.string :category
      t.date :approval_date
      t.string :upload
      t.boolean :status
      t.text :description
      t.references :allowance_sub_category

      t.timestamps
    end
    add_index :allowance_claim_transactions, :allowance_sub_category_id
  end
end
