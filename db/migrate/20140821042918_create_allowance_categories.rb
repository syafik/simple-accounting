class CreateAllowanceCategories < ActiveRecord::Migration
  def change
    create_table :allowance_categories do |t|
    	t.string :name


      t.timestamps
    end
  end
end
