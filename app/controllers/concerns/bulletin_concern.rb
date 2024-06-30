# frozen_string_literal: true

module BulletinConcern
  extend ActiveSupport::Concern

  def index
    @q = Bulletin.ransack(params[:q])
    @pagy, @bulletins = pagy(@q.result)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

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
