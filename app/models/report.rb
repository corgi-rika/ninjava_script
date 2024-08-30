class Report < ApplicationRecord
  belongs_to :mentor, class_name: 'User', foreign_key: 'mentor_id', optional: true  # 任意で紐付けられるメンター
  belongs_to :user  # ユーザーに紐付けられた日報

  with_options presence: true do
    validates :total_study_time
    validates :improvement_points
    validates :next_steps
    validates :next_study_day
  end

end
