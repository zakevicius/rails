Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'home/about'

  resources :friends

  get '/friends/:id/encrypt_data', to: 'friends#encrypt', as: 'encrypt_friend'
  get '/friends/:id/decrypt_data', to: 'friends#decrypt', as: 'decrypt_friend'
end
