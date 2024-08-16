class Word < ApplicationRecord
  belongs_to :user

  validates :word, presence: true, length: { maximum: 10}
  validates :meaning, presence: true, length: { maximum: 30 }
  validates :example, presence: true, length: { maximum: 100 }
end
