# frozen_string_literal: true

Rails.logger.debug 'Seeding bulletins'

preloaded_images = ActiveStorage::Blob.all

ActiveRecord::Base.transaction do
  200.times do
    bulletin = Bulletin.new(
      title: Faker::Games::DnD.title_name,
      description: Faker::Lorem.paragraphs.join("\n"),
      category: Category.find_by(id: rand(1..10)),
      user: User.find_by(id: (1..10))
    )

    bulletin.image.attach(preloaded_images.sample)

    bulletin.save
  end
end
