class CreateLoanPermissions < ActiveRecord::Migration
  def change
    create_table :loan_permissions do |t|
      t.date :submission_date
      t.date :approval_date
      t.float :total_loan
      t.text :message
      t.text :description
      t.references :users

      t.timestamps
    end
    add_index :loan_permissions, :users_id
  end
end
