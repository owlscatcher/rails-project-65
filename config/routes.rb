# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    resources :bulletins, except: %i[destroy] do
      member do
        patch :archive
        patch :to_moderate
      end
    end

    resources :profile, only: :index
  end

  namespace :admin do
    resources :bulletins, only: %i[index new create edit update destroy]
    resources :categories, only: %i[index new create edit update destroy]
    resources :users, only: %i[index new create edit update destroy]
  end

  root 'web/bulletins#index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
