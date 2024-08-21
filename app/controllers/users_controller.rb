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
    unless @user == current_user
      redirect_to root_path
    end
  end

end
