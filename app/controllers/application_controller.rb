# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pagy::Backend
  include Pundit::Authorization

  helper_method :signed_in?, :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from NotAuthenticatedError, with: :user_not_authenticated

  private

  def user_not_authorized
    flash[:warning] = t('user_not_authorized')
    redirect_to root_path
  end

  def user_not_authenticated
    flash[:warning] = t('user_not_authenticated')
    redirect_to root_path
  end
end
