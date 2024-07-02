# frozen_string_literal: true

module BulletinConcern
  extend ActiveSupport::Concern

  included do
    include AuthConcern

    before_action :authenticate_user!, except: %i[index show]
    before_action :set_bulletin,
                  only: %i[show edit update destroy archive to_moderate]
    after_action :verify_authorized, except: %i[index show]
  end

  def index
    items = signed_in? ? 11 : 12

    @q = Bulletin.published.ransack(params[:q])
    @pagy, @bulletins = pagy(@q.result.order(updated_at: :desc), items:)
  end

  def show; end

  def new
    authorize Bulletin
    @bulletin = Bulletin.new
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      flash[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @bulletin
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

  def destroy
    authorize @bulletin

    if @bulletin.destroy
      redirect_to bulletins_path, notice: t('.success')
    else
      redirect_to @bulletin, alert: t('.fail')
    end
  end

  def archive
    authorize @bulletin
    return unless @bulletin.may_archive?

    @bulletin.archive!
    redirect_to profile_path, notice: t('.success')
  end

  def to_moderate
    authorize @bulletin
    return unless @bulletin.may_to_moderate?

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
