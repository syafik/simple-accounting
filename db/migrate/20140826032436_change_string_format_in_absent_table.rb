class ChangeStringFormatInAbsentTable < ActiveRecord::Migration
  def up
  	change_column :absents, :description, :text
  end

  def down
  	change_column :absents, :description, :string
  end
end
