class DropAbsentTabel < ActiveRecord::Migration
  def change
  	drop_table :absents
  end
end