# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'
  end

  root 'web/home#index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
