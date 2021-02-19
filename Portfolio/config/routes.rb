# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :projects, except: %i[show]

  get 'project/:id', to: 'projects#show', as: 'show_project'

  resources :blogs do
    member do
      get :toggle_status
    end
  end
end
