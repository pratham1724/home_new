class Client < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :rated_trainers, through: :ratings, source: :trainer
  has_one_attached :profile
  
  validates :name, presence: true, uniqueness: true
  validates :phone_number, numericality: true, length: { is: 10, messages: "phone number must contain 10 digits" }
  validates :age, numericality: true
end
