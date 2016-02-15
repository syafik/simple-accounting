class CreateYearInsurances < ActiveRecord::Migration
  def change
    create_table :year_insurances do |t|
      t.integer :family_id
      t.string :year
      t.integer :saldo_rj
      t.integer :grade_id

      t.timestamps
    end
  end
end
