class Word < ApplicationRecord
  belongs_to :user

  validates :word, presence: true
  validates :meaning, presence: true
  validates :example, presence: true
end
