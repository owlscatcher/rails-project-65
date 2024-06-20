# frozen_string_literal: true

namespace :preload do
  desc 'Preload images from test/fixtures/files into ActiveStorage'
  task preload_images: :environment do
    images_path = Rails.root.join('test/fixtures/files')
    Dir.foreach(images_path) do |file_name|
      next if ['.', '..'].include?(file_name)

      file_path = File.join(images_path, file_name)
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(file_path),
        filename: file_name,
        content_type: `file --brief --mime-type #{file_path}`.strip
      )
    end

    puts 'Preloaded images into ActiveStorage'
  end
end
