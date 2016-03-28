class CreatePointHistories < ActiveRecord::Migration
  def change
    create_table :point_histories do |t|
      t.integer :point_id
      t.integer :user_id
      t.integer :points, :default => 0
      t.string :point_historyable_type
      t.integer :point_historyable_id

      t.timestamps
    end
  end
end
