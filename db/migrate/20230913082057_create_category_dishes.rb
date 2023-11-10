class CreateCategoryDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :category_dishes do |t|
      t.references :category,  null: false, foreign_key: true
      t.references :dish,      null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
