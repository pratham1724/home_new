class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {client: 0, trainer: 1}

  has_one :trainer, dependent: :destroy
  has_one :client, dependent: :destroy
end
