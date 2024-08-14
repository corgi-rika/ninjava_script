Rails.application.routes.draw do
  get 'main/home'
  devise_for :users

  root 'main#home'  # ここで `main` コントローラの `home` アクションをトップページに設定
end
