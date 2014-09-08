class AddColumnActivate < ActiveRecord::Migration
  def change
  	add_column :salary_histories, :activate, :boolean
  end
end
