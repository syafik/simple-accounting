class RenameSubmissionDate < ActiveRecord::Migration
  def change
  	rename_column :allowance_claim_transactions, :date_submission, :submission_date
  end
end
