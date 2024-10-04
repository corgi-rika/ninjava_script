class MainController < ApplicationController
  def home
    @user = current_user
    @reports = @user.reports

    # 今週の学習時間を取得
    start_of_week = Time.zone.now.beginning_of_week # 月曜日を週の始まりとする
    end_of_week = Time.zone.now.end_of_week # 日曜日を週の終わりとする
    @weekly_study_time = @reports.where(created_at: start_of_week..end_of_week).sum(:total_study_time)

    # メンターの場合
    if current_user.mentee.present?
      Rails.logger.debug "Mentee exists for user #{current_user.id}"

      latest_report = current_user.mentee.reports.order(created_at: :desc).first
      Rails.logger.debug "Latest report: #{latest_report.inspect}"

      @recent_report_created = latest_report.present?
      Rails.logger.debug "Recent report created: #{@recent_report_created}"

      # メンターの最新の返信があるか確認
      if latest_report && latest_report.feedback.present?
        Rails.logger.debug "Feedback exists for latest report"
        @recent_reply_created = true
      else
        @recent_reply_created = false
      end
      Rails.logger.debug "Recent reply created: #{@recent_reply_created}"

    # 学習者の場合
    else
      Rails.logger.debug "User is a learner"

      latest_report = current_user.reports.order(created_at: :desc).first
      Rails.logger.debug "Learner's latest report: #{latest_report.inspect}"

      @recent_report_created = latest_report.present?
      Rails.logger.debug "Recent report created: #{@recent_report_created}"

      # 学習者の最新のレポートにフィードバックがあるか確認
      if latest_report && latest_report.feedback.present?
        Rails.logger.debug "Feedback exists for learner's latest report"
        @recent_reply_created = true
      else
        @recent_reply_created = false
      end
      Rails.logger.debug "Recent reply created for learner: #{@recent_reply_created}"
    end
  end
end
