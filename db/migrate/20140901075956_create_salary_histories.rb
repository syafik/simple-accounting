class CreateSalaryHistories < ActiveRecord::Migration
  def change
    create_table :salary_histories do |t|
      t.integer :user_id
      t.float :payment
      t.date :date

      t.timestamps
    end
  end
end
