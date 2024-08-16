Rails.application.routes.draw do
  devise_for :users
  root to: 'main#home'

  resources :users, only: [] do
    resources :words, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end
end
