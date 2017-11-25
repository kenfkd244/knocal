Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :users, only: [:show, :edit, :update]
  resources :questions, only: [:index, :new, :create] do
    resources :answers, only: [:new, :create]
  end
end
