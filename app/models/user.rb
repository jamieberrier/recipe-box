class User < ActiveRecord::Base
  has_secure_password

  validates :email, :display_name, presence: true, uniqueness: { case_sensitive: false }

  has_many :recipes, inverse_of: :user

  def slug
    display_name.slugify
  end

  def self.find_by_slug(slug)
    User.all.find{ |user| user.slug == slug }
  end
end
