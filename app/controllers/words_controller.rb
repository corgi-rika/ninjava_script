class WordsController < ApplicationController
  before_action :set_user
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user # アクセス制御を追加。これでユーザーは他のユーザーのページを閲覧することはできない


  def index
    @words = @user.words.order(created_at: :desc).page(params[:page]).per(10)# 1ページあたり10件の単語を表示
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
      redirect_to user_word_path(@user, @word), notice: '変更をくわえました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @word.destroy
    redirect_to user_words_path(@user), notice: '単語が削除されました。'
  end

  def search
    # モデルのsearchメソッドを呼び出し、検索結果を取得
    @words = @user.words.search(params[:keyword]).page(params[:page]).per(10)
    # 元の単語一覧での位置（番号）を表示するために、ID順にリストを取得
    @all_words_ids = @user.words.order(created_at: :desc).pluck(:id)
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    # 他の学習者のidを使用してアクセスしようとした場合にトップページにリダイレクトされる
    if @user.nil?
      redirect_to root_path, alert: '指定されたユーザーは存在しません。'
    end
  end

  def set_word
    @word = @user.words.find_by(id: params[:id])
    # 削除済みの単語の詳細ページにアクセスしようとした場合にトップページにリダイレクトされる
    if @word.nil?
      redirect_to root_path, alert: '指定された単語は存在しません。'
    end
  end

  def authorize_user
    unless @user == current_user || @user == current_user.mentee || @user == current_user.mentor
      redirect_to root_path
    end
  end

  def word_params
    params.require(:word).permit(:word, :meaning, :example, :hiragana)
  end
end
