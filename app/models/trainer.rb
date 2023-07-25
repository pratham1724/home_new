class Trainer < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_one_attached :profile
  has_many :ratings, class_name: "Rating", dependent: :destroy
  has_many :rating_clients, through: :ratings, source: :client
end
