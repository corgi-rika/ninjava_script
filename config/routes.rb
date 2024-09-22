Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'main#home'

  resources :users, only: [:show] do
    resources :words do
      collection do
        get 'search' # 検索用のルートを追加
      end
      resources :quizzes, only: [:index, :create, :show] do # クイズ用のルーティングを追加
        # クイズ終了後の処理用のルートを追加
        member do
          post 'finish' #終了後のクイズリセットアクション
        end
      end
    end

    # 日報用のルーティングを追加
    resources :reports
  end

  # 結果ページへのルート
  get 'results/:user_id/:word_id', to: 'quizzes#results', as: 'user_results'
  # セッションリセット用のルート
  delete 'reset_session/:user_id', to: 'quizzes#reset_session', as: 'reset_session'

  # メンター登録用のルートを追加
  get 'mentor_registration', to: 'mentorships#new'
  post 'mentor_registration', to: 'mentorships#create'
end
