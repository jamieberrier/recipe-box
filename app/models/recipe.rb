class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :name, :total_time, :cook_time, :instructions, :course, presence: true
  validates :name, uniqueness: true

  has_many :recipe_ingredients, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients

  def slug
    name.slugify
  end

  def self.find_by_slug(slug)
    Recipe.all.find{ |recipe| recipe.slug == slug }
  end
end
