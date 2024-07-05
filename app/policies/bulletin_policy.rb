# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? or author? or admin?
  end

  def new?
    create?
  end

  def create?
    user
  end

  def edit?
    update?
  end

  def update?
    author? or admin?
  end

  def to_moderate?
    archive?
  end

  def archive?
    author? or admin?
  end

  private

  def author?
    user && record.user == user
  end

  def admin?
    user&.admin?
  end
end
