class CreateAbsentPermissions < ActiveRecord::Migration
  def change
    create_table :absent_permissions do |t|
      t.integer :category
      t.date :date_submission
      t.date :approval_date
      t.boolean :status
      t.integer :long
      t.text :description
      t.references :user

      t.timestamps
    end
    add_index :absent_permissions, :user_id
  end
end
