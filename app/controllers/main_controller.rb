class MainController < ApplicationController
  def home
        @user = current_user
        @reports = @user.reports

        # 今週の学習時間を取得
        start_of_week = Time.zone.now.beginning_of_week# 月曜日を週の始まりとする
        end_of_week = Time.zone.now.end_of_week# 日曜日を週の終わりとする
        @weekly_study_time = @reports.where(created_at: start_of_week..end_of_week).sum(:total_study_time)

        if current_user.mentee.present?
          latest_report = current_user.mentee.reports.order(created_at: :desc).first
          @recent_report_created = latest_report && latest_report.created_at > 24.hours.ago

          # メンターの返信が24時間以内に行われたか確認
          if latest_report && latest_report.feedback.present?
            @recent_reply_created = latest_report.updated_at > 24.hours.ago
          else
            @recent_reply_created = false
          end
        else
          @recent_report_created = false
          @recent_reply_created = false
        end
  end
end
