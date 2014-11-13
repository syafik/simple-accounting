class AddAllowedJamsostekToSalaryHistory < ActiveRecord::Migration
  def change
    add_column :salary_histories, :allowed_jamsostek, :boolean
  end
end
