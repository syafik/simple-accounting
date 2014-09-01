class MoveMaxDay < ActiveRecord::Migration
  def change
  	add_column :allowance_sub_categories, :max_day, :integer
  end
end
