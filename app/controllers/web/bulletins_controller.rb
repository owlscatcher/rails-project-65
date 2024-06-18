# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.all
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      @bulletin = Bulletin.new
    end

    def create
      @bulletin = Bulletin.new(bulletin_params)
      @bulletin.user_id = current_user.id

      if @bulletin.save
        redirect_to @bulletin
      else
        render :new
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
  end
end
