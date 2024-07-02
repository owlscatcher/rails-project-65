# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin_draft = bulletins(:draft)
    @buletin_archived = bulletins(:archived)
    @user = users(:one)
    @category = categories(:one)
    @attr = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      image: fixture_file_upload('1.jpg', 'image/jpg'),
      category_id: @category.id
    }
  end

  test 'should get root' do
    get root_path
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:one)
    get new_bulletin_path
    assert_response :success
  end

  test 'should create new bulletins' do
    sign_in @user
    post bulletins_url, params: { bulletin: @attr }

    bulletin = Bulletin.find_by(@attr.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end
end
