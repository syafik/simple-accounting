class CreateReimbursements < ActiveRecord::Migration
  def change
    create_table :reimbursements do |t|
      t.integer :year_insurance_id
      t.integer :user_id
      t.string :no_kwitasi
      t.string :rumah_sakit
      t.integer :total_claim
      t.string :status
      t.string :reimbursement_type
      t.text :notes

      t.timestamps
    end
  end
end
