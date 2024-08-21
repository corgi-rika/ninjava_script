Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'main#home'

  resources :users, only: [:show] do
    resources :words do
    resources :quizzes, only: [:index, :create, :show] # クイズ用のルーティングを追加
    end
  end

  # 結果ページへのルート
  get 'results/:user_id/:word_id', to: 'quizzes#results', as: 'user_results'
  # セッションリセット用のルート
  delete 'reset_session/:user_id', to: 'quizzes#reset_session', as: 'reset_session'



end
