class MentorshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    # メンター登録のための新しいフォームを表示
  end

  def create
    mentor = User.find_by(code: params[:mentor_code])
    if mentor.present? && mentor.role == 1 #メンターが存在し、かつメンターの役割であるかを確認
      current_user.update(mentor_id: mentor.id) # 学習者にメンターを紐づける
      redirect_to root_path, notice: 'メンターが正常に登録されました！'
    else
      flash.now[:alert] = '無効なメンターコードです。もう一度お試しください'
      render :new
    end
  end
end
