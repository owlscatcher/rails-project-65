# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      include BulletinConcern
      before_action :set_bulletin,
                    only: %i[publish archive reject]

      def index
        @q = Bulletin.ransack(params[:q])
        @pagy, @bulletins = pagy(@q.result.order(updated_at: :desc))
      end

      def archive
        authorize @bulletin
        return unless @bulletin.may_archive?

        @bulletin.archive!
        redirect_back fallback_location: admin_path, notice: t('.success')
      end

      def publish
        authorize @bulletin
        return unless @bulletin.may_publish?

        @bulletin.publish!
        redirect_to admin_path, notice: t('.success')
      end

      def reject
        authorize @bulletin
        return unless @bulletin.may_reject?

        @bulletin.reject!
        redirect_to admin_path, notice: t('.success')
      end
    end
  end
end
