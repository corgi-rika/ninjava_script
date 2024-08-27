class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  # `show`, `edit`, `update`, `destroy` アクションの前に特定の日報をセット
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = @user.reports

    # 日付フィルタリング
    if params[:start_date].present? && params[:end_date].present?
      @reports = @reports.where(created_at: params[:start_date]..params[:end_date])
    end

    # 作成日の降順で並べ替え、ページネーションを適用
    @reports = @reports.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    # `set_report` により対象の日報が @report にセットされている
  end

  def new
    # 新しい日報オブジェクトを作成
    @report = @user.reports.new
  end

  def create
    @report = @user.reports.new(report_params)
    if @report.save
      redirect_to reports_path, notice: "日報を作成しました"
    else
      render :new
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: "日報を削除しました。"
  end

  private

  def set_user
    @user = current_user
  end

  def set_report
    #ログインユーザーが作成した日報のみを検索
    @report = @user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:total_study_time, :good_points, :improvement_points, :next_steps, :next_study_day, :feedback)
  end

end
