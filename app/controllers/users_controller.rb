class UsersController < ApplicationController
  before_action :set_user
  before_action :authorize_user # アクセス制御を追加。これでユーザーは他のユーザーのページを閲覧することはできない

  def show
  end







  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    Rails.logger.debug "Checking authorization: @user=#{@user.id}, current_user=#{current_user.id}, mentor=#{current_user.mentor&.id}"

    unless @user == current_user || @user == current_user.mentee || @user == current_user.mentor
      redirect_to root_path, alert: "他のユーザーのプロフィールにはアクセスできません"

    end
  end

end
