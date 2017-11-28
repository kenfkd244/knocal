Rails.application.routes.draw do
  devise_for :users
  root "questions#index"
  resources :users, only: [:show, :edit, :update]
  resources :questions, only: [:index, :show, :new, :create] do
    resources :answers, only: [:new, :create]
  end
end
