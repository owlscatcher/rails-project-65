# frozen_string_literal: true

class Bulletin < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  scope :latest, -> { order(created_at: :desc) }

  scope :on_moderation, -> { order(state: :moderation) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at description id id_value title updated_at user_id]
  end
end
