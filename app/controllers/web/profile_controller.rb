# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def index
      authenticate_user!

      @q = current_user.bulletins.ransack(params[:q])
      @pagy, @bulletins = pagy(@q.result.order(updated_at: :desc))
    end
  end
end
