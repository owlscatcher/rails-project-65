# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    resources :profile, only: :index

    resources :bulletins, except: %i[destroy] do
      member do
        patch :archive, :to_moderate
      end
    end

    namespace :admin do
      root 'home#index'
      resources :bulletins do
        member do
          patch :archive, :publish, :reject
        end
      end
      resources :categories, except: %i[show]
      resources :users, only: %i[index edit update destroy]
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
