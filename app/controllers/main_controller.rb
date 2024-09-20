class MainController < ApplicationController
  def home
        @user = current_user
        @reports = @user.reports

        # 今週の学習時間を取得
        start_of_week = Time.zone.now.beginning_of_week# 月曜日を週の始まりとする
        end_of_week = Time.zone.now.end_of_week# 日曜日を週の終わりとする
        @weekly_study_time = @reports.where(created_at: start_of_week..end_of_week).sum(:total_study_time)
  end
end
