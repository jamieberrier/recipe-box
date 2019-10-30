class Recipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  validates :user, presence: true
  validates :name, :total_time, :cook_time, :instructions, :course_id, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :recipe_ingredients, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients

  def slug
    name.slugify
  end

  def self.find_by_slug(slug)
    Recipe.all.find{ |recipe| recipe.slug == slug }
  end

  def self.search_name(search_term)
    where('name like :pat', pat: "%#{search_term}%")
  end
end
