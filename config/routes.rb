Rails.application.routes.draw do
  devise_for :users
  root to: 'main#home'

  resources :users, only: [] do
    resources :words, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :quizzes, only: [:index, :create, :show] # クイズ用のルーティングを追加
    end
  end

  get 'results/:user_id', to: 'quizzes#results', as: 'user_results'
  # 結果ページへのルート

end
