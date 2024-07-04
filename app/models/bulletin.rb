# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image do |attached|
    attached.variant :for_form, resize_to_limit: [nil, 100]
  end

  belongs_to :user, counter_cache: :bulletins_count
  belongs_to :category, optional: false

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  scope :latest_published, -> { where(state: :published).order(created_at: :desc) }

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
