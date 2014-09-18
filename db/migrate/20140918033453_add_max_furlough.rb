class AddMaxFurlough < ActiveRecord::Migration
  def change
  	add_column :users, :max_furlough, :integer
  end
end
