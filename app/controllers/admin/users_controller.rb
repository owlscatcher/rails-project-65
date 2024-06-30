# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def index
      @pagy, @users = pagy(User.all)
    end

    def show
      @user = User.find(params[:id])
    end
  end
end
