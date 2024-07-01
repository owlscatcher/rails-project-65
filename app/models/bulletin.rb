# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  scope :latest, -> { order(created_at: :desc) }
  scope :on_moderation, -> { where(state: :to_moderate) }
  scope :published, -> { where(state: :published) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at description id id_value title updated_at user_id]
  end

  include AASM

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end
end
