class QuizzesController < ApplicationController
  before_action :set_user
  before_action :set_word, only: [:show, :index]

  def reset_session
    session[:quiz_count] = 0
    session[:correct_count] = 0
    session[:already_counted] = nil
    redirect_to root_path, notice: 'クイズを中断しました'
  end

  def index
    session[:quiz_count] ||= 0
    session[:correct_count] ||= 0
    session[:already_counted] = nil  # クイズが始まる前にフラグをリセット

    Rails.logger.info "Current Quiz Count: #{session[:quiz_count]}"  # クイズカウントをログに出力


    # ランダムに単語を選ぶ処理をデータベースに応じて変更
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      @word = @user.words.order("RANDOM()").first
      correct_word = @word
      other_words = Word.where.not(id: @word.id).order("RANDOM()").limit(3)
    else
      @word = @user.words.order("RAND()").first
      correct_word = @word
      other_words = Word.where.not(id: @word.id).order("RAND()").limit(3)
    end

    # 動的にクイズオプションを生成する
    @options = other_words.pluck(:meaning).append(correct_word.meaning).shuffle

    @quiz = Quiz.create!(
      word: correct_word,
      correct_answer: correct_word.meaning,
      option1: other_words[0].meaning,
      option2: other_words[1].meaning,
      option3: other_words[2].meaning,
      option4: correct_word.meaning
    )

    if @quiz.persisted?
      Rails.logger.info "Quiz created successfully with ID: #{@quiz.id}"
    else
      Rails.logger.error "Quiz creation failed."
    end



    if session[:quiz_count] >= 10
      redirect_to user_results_path(@user.id, word_id: @word.id) and return
    else
      session[:quiz_count] += 1
    end
  end

  def show
    @quiz = Quiz.find_by(id: params[:id])
    @selected_word = params[:answer]
    @correct_word = @quiz.correct_answer

    if @quiz.nil?
      flash[:alert] = 'クイズが見つかりませんでした。'
      redirect_to user_word_quizzes_path(@user, @word) and return
    end

    # 正解かどうかを判定し、正解数を増やす
    Rails.logger.info "Selected: #{@selected_word}, Correct: #{@correct_word}, Already Counted: #{session[:already_counted]}"
    if @selected_word == @correct_word
      unless session[:already_counted] # すでにカウント済みか確認
        session[:correct_count] += 1
        session[:already_counted] = true
      end
    else
      session[:already_counted] = false
    end

    @word = @quiz.word
  end

  def results
    @user = User.find(params[:user_id])
    @word = Word.find(params[:word_id])
    @correct_count = session[:correct_count]

    # セッションをリセット
    session[:quiz_count] = 0
    session[:correct_count] = 0
    session[:already_counted] = nil # 次回のクイズ用にリセット
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_word
    @word = Word.find(params[:word_id])
  end
end
