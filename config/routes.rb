Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, only: %i[ index new create]
  resources :categories, only: %i[index new create]
end
