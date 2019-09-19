=begin
name, description, total_time, cook_time, instructions, image_url, course
=end
class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  # validates :name, :description, :total_time, :cook_time, :instructions, :course, presence: true

  has_many :recipe_ingredients, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients
end
