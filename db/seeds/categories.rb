# frozen_string_literal: true

Rails.logger.debug 'Seeding Categories'

10.times do
  Category.create(name: Faker::Games::DnD.title_name)
end
