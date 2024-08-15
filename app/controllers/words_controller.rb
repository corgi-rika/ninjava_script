class WordsController < ApplicationController
  before_action :set_user

  def new
    @word = Word.new
  end

  def create
    @word = @user.words.build(word_params)
    if @word.save
      redirect_to root_path, notice: '単語が登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def word_params
    params.require(:word).permit(:word, :meaning, :example)
  end
end
