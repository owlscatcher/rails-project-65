# frozen_string_literal: true

module Web
  module Admin
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show edit update destroy]

      def index
        @pagy, @users = pagy(User.order(:id))
      end

      def show; end

      def edit; end

      def update
        if @user.update(user_params)
          redirect_to admin_users_path, notice: t('.success')
        else
          flash[:alert] = t('.fail')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy
          redirect_to admin_users_path, notice: t('.success')
        else
          flash[:alert] = t('.fail')
          render :edit, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :admin)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
