class Post < ApplicationRecord
  belongs_to :user

  validates :title, :slug, :body, presence: true
  validates :slug, uniqueness: true
end
