Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  root 'users#index'
  devise_for :users
  resources :posts, only: %i[new create show destroy]
  resources :users, only: %i[index show]
  resources :comments, only: %i[new create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
