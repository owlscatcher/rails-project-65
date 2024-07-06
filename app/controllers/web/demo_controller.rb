# frozen_string_literal: true

module Web
  class DemoController < ApplicationController
    before_action :set_user

    def change_access
      authenticate_user!

      @user.update(admin: !current_user&.admin)
      flash[:notice] = if current_user&.admin
                         t('.downgrade')
                       else
                         t('.upgrade')
                       end

      redirect_to root_path
    end

    private

    def set_user
      @user = User.find_by(id: current_user.id)
    end
  end
end
