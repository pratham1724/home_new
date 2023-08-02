class Trainer < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_one_attached :profile
  has_many :ratings, class_name: "Rating", dependent: :destroy
  has_many :rating_clients, through: :ratings, source: :client
  
  validates :name, presence: true, uniqueness: true
  validates :phone_number, numericality: true, length: { is: 10, messages: "phone number must contain 10 digits" }
  validates :age, numericality: true
end
