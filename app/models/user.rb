class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
         
  enum role: {client: 0, trainer: 1}

  has_one :trainer, dependent: :destroy
  has_one :client, dependent: :destroy
  has_many :messages, dependent: :destroy
end
