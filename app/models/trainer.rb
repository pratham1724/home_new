class Trainer < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :appointments, dependent: :destroy
end
