Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  resources :comments, only: %i[new create] do
    resources :likes, only: %i[create]
  end
  resources :posts, only: %i[new create show destroy] do
    resources :likes, only: %i[create]
  end
  resources :users, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
