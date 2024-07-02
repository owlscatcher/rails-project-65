# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < ApplicationController
      before_action :authorize_admin

      private

      def authorize_admin
        return if current_user&.admin?

        flash[:warning] = t('user_not_admin')
        redirect_to root_path
      end
    end
  end
end
