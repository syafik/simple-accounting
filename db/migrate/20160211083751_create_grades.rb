class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.integer :ri
      t.integer :rj
      t.integer :rb_normal
      t.integer :rb_caesar
      t.integer :operasi
      t.boolean :is_active, default: false
      t.integer :start_salary
      t.integer :end_salary

      t.timestamps
    end

    add_index :grades, :ri
    add_index :grades, :rj
    add_index :grades, :rb_normal
    add_index :grades, :rb_caesar
    add_index :grades, :operasi
    add_index :grades, :is_active
    add_index :grades, :start_salary
    add_index :grades, :end_salary
  end
end
