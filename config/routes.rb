Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :clothes, only: [:new, :create]
  resources :blankets, only: [:new, :create]
end
