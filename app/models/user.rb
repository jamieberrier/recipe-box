class User < ActiveRecord::Base
  has_secure_password

  validates :email, :display_name, presence: true, uniqueness: true

  has_many :recipes, inverse_of: :user
end
