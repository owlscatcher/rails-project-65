# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 255 } # rubocop:disable Rails/UniqueValidationWithoutIndex
end
