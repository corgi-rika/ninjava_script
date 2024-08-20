class Word < ApplicationRecord
  belongs_to :user
  has_many :quizzes, dependent: :destroy

  validates :word, presence: true, length: { maximum: 10}
  validates :meaning, presence: true, length: { maximum: 30 }
  validates :example, presence: true, length: { maximum: 100 }

  # 新しく追加されたひらがなカラムに対するバリデーション
  validates :hiragana, length: { maximum: 10 }, allow_blank: true
end
