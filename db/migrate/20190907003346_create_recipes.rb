class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :total_time
      t.string :cook_time
      t.string :instructions

      t.timestamps null: false
    end
  end
end
