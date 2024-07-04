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

    get 'profile', to: 'profile#index', as: :profile

    namespace :admin do
      get '/', to: 'home#index'
      resources :bulletins do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
      resources :categories, except: %i[show]
      resources :users, only: %i[index edit update destroy]
    end
  end

  root 'web/bulletins#index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
