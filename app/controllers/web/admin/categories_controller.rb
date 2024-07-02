# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[edit update destroy]

      def index
        @pagy, @categories = pagy(Category.all)
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('.success')
        else
          flash.now['alert'] = t('.fail')
          render :new, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('.success')
        else
          flash.now['alert'] = t('.fail')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.destroy
          redirect_to admin_categories_path, notice: t('.success')
        else
          flash.now['alert'] = t('.fail')
          render admin_categories_path, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
