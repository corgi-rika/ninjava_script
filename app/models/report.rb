class Report < ApplicationRecord
  belongs_to :user
  belongs_to :mentor, class_name: 'User', optional: true  # MentorはUserを指すと定義
  belongs_to :user  # ユーザーに紐付けられた日報
end
