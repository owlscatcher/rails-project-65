# frozen_string_literal: true

Rails.logger.debug 'Seeding users'

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email(domain: 'local.ru'),
    admin: true
  )
end
