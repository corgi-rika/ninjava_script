class QuizzesController < ApplicationController
  before_action :set_user

  def index
    session[:quiz_count] ||= 0

    # ランダムに単語を選ぶ
    @word = @user.words.order("RAND()").first
    correct_word = @word
    other_words = Word.where.not(id: correct_word.id).order("RAND()").limit(3)

  # 動的にクイズオプションを生成する
  @options = other_words.pluck(:word).append(correct_word.word).shuffle

    # ランダムにクイズを選択するか新しいクイズを作成する
    @quiz = Quiz.where(word: correct_word).order("RAND()").first || Quiz.create!(
      word: correct_word,
      correct_answer: correct_word.word,
      option1: other_words[0].word,
      option2: other_words[1].word,
      option3: other_words[2].word,
      option4: correct_word.word
    )

    # クイズを一問だけ@quizzesに入れる
    @quizzes = [@quiz]

    if session[:quiz_count] >= 10
      redirect_to user_results_path(@user)
    else
      session[:quiz_count] += 1
    end
  end

  def show
    @quiz = Quiz.find_by(id: params[:id])

    # 学習者が選んだ単語を取得
    @selected_word = params[:answer] # 学習者が選んだ単語

      # 正解の単語を取得
    @correct_word = @quiz.correct_answer



    if @quiz.nil?
      flash[:alert] = 'クイズが見つかりませんでした。'
      redirect_to user_word_quizzes_path(@user, @word)
    else
      @word = @quiz.word
    end
  end

  def results
    @user = User.find(params[:user_id])
    session[:quiz_count] = 0
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
