class Client < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :rated_trainers, through: :ratings, source: :trainer
end
