class CreateLoanPayments < ActiveRecord::Migration
  def change
    create_table :loan_payments do |t|
      t.date :submission_date
      t.date :approval_date
      t.float :total_payment
      t.text :message
      t.text :description
      t.references :LoanPermission

      t.timestamps
    end
    add_index :loan_payments, :LoanPermission_id
  end
end
