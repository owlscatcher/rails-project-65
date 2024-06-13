# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      return redirect_to root_path, notice: t('.already_signed_in') if signed_in?

      auth = request.env['omniauth.auth']
      email, name = user_info[:info].values_at(:email, :name)

      user = User.find_or_initialize_by(email: email.downcase)
      user.update(name:)

      sign_in user
      redirect_to root_path, notice:('.signed_in')
    end

    def login
      sign_out
      redirect_to root_path, notice:('.signed_out')
    end
  end
end
