class RemoveCourseColumnFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :course, :string
  end
end
