class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name,       default: "", null: false
      t.text :flavor_text,  null: false

      t.timestamps null: false
    end
  end
end
