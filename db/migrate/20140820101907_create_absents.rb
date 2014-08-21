class CreateAbsents < ActiveRecord::Migration
  def change
    create_table :absents do |t|
      t.date :date
      t.integer :user_id
      t.integer :categories
      t.string :description

      t.timestamps
    end
  end
end
