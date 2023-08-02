class Post < ApplicationRecord
  belongs_to :trainer
  has_many :comments, dependent: :destroy
  has_many_attached :images
  validates :title, presence: true
end
