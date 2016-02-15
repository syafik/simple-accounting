class AddGradeIdToSalaryHistory < ActiveRecord::Migration
  def change
    add_column :salary_histories, :grade_id, :integer
    add_index :salary_histories, :grade_id
  end
end
