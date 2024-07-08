# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def index
      authenticate_user!

      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.order(updated_at: :desc).page(params[:page])
    end
  end
end
