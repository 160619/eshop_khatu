Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :products, only: %i[ index new create]
  resources :categories, only: %i[index new create]
end
