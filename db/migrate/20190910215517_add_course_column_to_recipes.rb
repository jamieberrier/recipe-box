class AddCourseColumnToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :course, :string
  end
end
