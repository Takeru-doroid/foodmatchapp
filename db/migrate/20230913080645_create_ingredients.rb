class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name,            default: "", null: false
      t.text :flavor_text,       null: false
      t.string :cooking_effect,  default: "", null: false
      t.references :category,    null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
