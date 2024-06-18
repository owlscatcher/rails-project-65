# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, presence: true, uniqueness: true # rubocop:disable Rails/UniqueValidationWithoutIndex
end
