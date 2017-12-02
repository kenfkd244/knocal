Rails.application.routes.draw do
  devise_for :users
  root "questions#index"
  resources :users, only: [:show, :edit, :update]
  resources :questions do
    resources :answers
  end
end
