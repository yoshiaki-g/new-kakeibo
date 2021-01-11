class User < ApplicationRecord
  has_many :incomes
  has_many :fixedcosts
  has_many :variablecosts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
end
