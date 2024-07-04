# frozen_string_literal: true

module Web
  module Admin
    class HomeController < ApplicationController
      def index
        @pagy, @bulletins = pagy(Bulletin.under_moderation.order(updated_at: :desc))
      end
    end
  end
end
