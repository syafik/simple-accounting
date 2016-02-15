class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.date :birth_date
      t.string :status
      t.integer :parent_id
      t.integer :familyable_id
      t.string :familyable_type
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
