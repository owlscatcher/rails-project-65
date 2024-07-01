# frozen_string_literal: true

module Admin
  class BulletinsController < ApplicationController
    include BulletinConcern

    def publish; end

    def reject; end

    def archive; end
  end
end
