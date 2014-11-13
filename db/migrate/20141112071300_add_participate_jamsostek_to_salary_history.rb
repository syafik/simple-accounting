class AddParticipateJamsostekToSalaryHistory < ActiveRecord::Migration
  def change
    add_column :salary_histories, :participate_jamsostek, :boolean
  end
end
