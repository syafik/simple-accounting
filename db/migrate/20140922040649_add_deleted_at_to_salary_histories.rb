class AddDeletedAtToSalaryHistories < ActiveRecord::Migration
  def change
    add_column :salary_histories, :deleted_at, :datetime
    add_index :salary_histories, :deleted_at
  end
end
