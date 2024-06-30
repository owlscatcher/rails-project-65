# frozen_string_literal: true

module Admin
  class ApplicationController < ApplicationController
    before_action :authorize_admin

    private

    def authorize_admin
      redirect_to root_path, alert: t('user_not_admin') unless current_user&.admin?
    end
  end
end
