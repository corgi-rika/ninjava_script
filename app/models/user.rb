class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Wordsテーブルとの関連付け
  has_many :words, dependent: :destroy


  validates :role, presence: true
end
