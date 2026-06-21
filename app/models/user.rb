class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true
end
