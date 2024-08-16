class WordsController < ApplicationController
  before_action :set_user
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user # アクセス制御を追加。これでユーザーは他のユーザーのページを閲覧することはできない


  def index
    @words = @user.words.order(created_at: :desc)# 学習者が登録した単語を取得する処理
  end

  def show

  end


  def new
    @word = Word.new
  end

  def create
    @word = @user.words.build(word_params)
    if @word.save
      redirect_to user_words_path(@user), notice: '単語が登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      redirect_to user_word_path(@user, @word)
    # else
    #   render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @word.destroy
    redirect_to user_words_path(@user), notice: '単語が削除されました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_word
    @word = @user.words.find_by(id: params[:id])
    # 削除済みの単語の詳細ページにアクセスしようとした場合にトップページにリダイレクト
    if @word.nil?
      redirect_to root_path, alert: '指定された単語は存在しません。'
    end
  end

  def authorize_user
    unless @user == current_user
      redirect_to root_path
    end
  end

  def word_params
    params.require(:word).permit(:word, :meaning, :example)
  end
end
