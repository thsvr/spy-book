Rails.application.routes.draw do
  root 'users#index'
  devise_for :users
  resources :posts, only: %i[new create show destroy]
  resources :users, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
