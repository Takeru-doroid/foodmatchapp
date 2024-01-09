class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, default: "", null: false

      t.timestamps null: false
    end
  end
end
