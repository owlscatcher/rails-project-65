# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :signed_in?
  include AuthConcern
end
