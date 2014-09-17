class RenameDateSubmission < ActiveRecord::Migration
  def change
  	rename_column :absent_permissions, :date_submission, :submission_date
  end
end
