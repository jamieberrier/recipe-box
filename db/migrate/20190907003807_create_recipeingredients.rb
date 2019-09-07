class CreateRecipeingredients < ActiveRecord::Migration
  def change
    create_table :recipeingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.string :amount

      t.timestamps null: false
    end
  end
end
