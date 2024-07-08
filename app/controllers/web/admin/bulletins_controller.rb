# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      before_action :set_bulletin,
                    only: %i[publish archive reject]

      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.order(updated_at: :desc).page(params[:page])
      end

      def archive
        if @bulletin.may_archive?
          @bulletin.archive!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.fail')
        end
      end

      def publish
        if @bulletin.may_publish?
          @bulletin.publish!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.fail')
        end
      end

      def reject
        if @bulletin.may_reject?
          @bulletin.reject!
          redirect_to admin_root_path, notice: t('.success')
        else
          redirect_to admin_root_path, alert: t('.fail')
        end
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
