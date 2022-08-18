class Article < ApplicationRecord
  acts_as_paranoid
  has_one_attached :cover_image

  # relationships
  belongs_to :user
  has_many :comments
  has_many :like_articles
  has_many :users, through: :like_articles

  # validations
  validates :title, presence: true,
                    length: { minimum: 2 }
end
