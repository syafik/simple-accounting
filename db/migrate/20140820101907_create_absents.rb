class CreateAbsents < ActiveRecord::Migration
  def change
    create_table :absents do |t|
      t.date :date
      t.int :user_id
      t.int :categories
      t.string :description

      t.timestamps
    end
  end
end
