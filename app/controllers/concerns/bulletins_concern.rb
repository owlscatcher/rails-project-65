# frozen_string_literal: true

module BulletinsConcern
  extend ActiveSupport::Concern

  included do
    include AuthConcern

    before_action :authenticate_user!, except: %i[index show]
    before_action :set_bulletin,
                  only: %i[show edit update archive to_moderate]
  end

  def index
    items = signed_in? ? 11 : 12

    @q = Bulletin.published.includes(:user).with_attached_image.ransack(params[:q])
    @pagy, @bulletins = pagy(@q.result.order(updated_at: :desc), items:)
  end

  def show
    authorize @bulletin
  end

  def new
    @bulletin = current_user.bulletins.build
    authorize @bulletin
  end

  def edit
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      flash.now['alert'] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    return unless @bulletin.may_archive?

    authorize @bulletin

    @bulletin.archive!
    redirect_to profile_path, notice: t('.success')
  end

  def to_moderate
    return unless @bulletin.may_to_moderate?

    authorize @bulletin

    @bulletin.to_moderate!
    redirect_to profile_path, notice: t('.success')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
end
