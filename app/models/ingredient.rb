class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients, inverse_of: :ingredient
  has_many :recipes, through: :recipe_ingredients

  def self.search(search)
    where('name like :pat', :pat => "%#{search}%")
  end
end
