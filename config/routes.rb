Rails.application.routes.draw do
  devise_for :users
  root to: 'main#home'

  resources :users, only: [] do
    resources :words, only: [:index, :new, :create, :show]
  end
end

# Rails.application.routes.draw do
#   get 'main/home'
#   devise_for :users

#   root 'main#home'  # ここで `main` コントローラの `home` アクションをトップページに設定
# end
