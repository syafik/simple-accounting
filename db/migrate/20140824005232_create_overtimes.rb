class CreateOvertimes < ActiveRecord::Migration
  def change
    create_table :overtimes do |t|
      t.date :date
      t.integer :user_id
      t.integer :long_overtime
      t.string :description

      t.timestamps
    end
  end
end
