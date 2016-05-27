class CreateBestEmployees < ActiveRecord::Migration
  def change
    create_table :best_employees do |t|
      t.integer :user_id
      t.date :date
      t.integer :total_point
      t.integer :min_point
      t.timestamps
    end
    Point.create(:name => "minimal")
  end
end
