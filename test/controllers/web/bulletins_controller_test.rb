# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @draft = bulletins(:draft)
    @under_moderation = bulletins(:under_moderation)
    @archive = bulletins(:archived)

    @first_author = users(:first_author)
    @second_author = users(:second_author)
    @admin = users(:admin)

    @attr = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      image: fixture_file_upload('1.jpg', 'image/jpg'),
      category_id: categories(:one).id
    }
  end

  test 'should get root' do
    get root_path
    assert_response :success
  end

  test 'should get new for auth user' do
    sign_in @first_author

    get new_bulletin_path
    assert_response :success
  end

  test 'should not get new for not auth users' do
    get new_bulletin_url

    assert_redirected_to root_url
  end

  test 'should create new bulletins' do
    sign_in @first_author

    post bulletins_url, params: { bulletin: @attr }

    bulletin = Bulletin.find_by(@attr.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end

  test 'should not create new bulletin for logout user' do
    post bulletins_url, params: { bulletin: @attr }

    bulletin = Bulletin.find_by(@attr.except(:image))
    assert { bulletin.nil? }
    assert_redirected_to root_path
  end

  test 'should update bulletin' do
    sign_in @first_author

    patch bulletin_path(@draft), params: { bulletin: @attr }

    @draft.reload

    assert { @draft.title == @attr[:title] }
    assert { @draft.description == @attr[:description] }
    assert_redirected_to bulletin_path(@draft)
  end

  test 'should update bulletin with params' do
    sign_in @first_author

    patch bulletin_path(@draft), params: {
      bulletin: {
        title: 'New Title',
        image: {
          content_type: 'image/png',
          original_filename: 'test.png',
          tempfile: "#\u003cFile:0x00007fcae65c0720\u003e"
        }
      }
    }

    @draft.reload

    assert { @draft.title == 'New Title' }
    assert_redirected_to bulletin_path(@draft)
  end

  test 'should update bulletin as user not author' do
    sign_in @second_author

    patch bulletin_path(@draft), params: { bulletin: @attr }
    assert_redirected_to root_path
  end

  test 'should archive bulletins' do
    sign_in @first_author

    patch archive_bulletin_path(@draft)

    assert @draft.reload.archived?
    assert_redirected_to profile_index_path
  end

  test 'should archive bulletins for admin user' do
    sign_in @admin

    patch archive_bulletin_path(@under_moderation)

    assert @under_moderation.reload.archived?
    assert_redirected_to profile_index_path
  end

  test 'should moderate bulletins for admin user' do
    sign_in @admin

    patch to_moderate_bulletin_path(@draft)

    assert @draft.reload.under_moderation?
    assert_redirected_to profile_index_path
  end

  test 'should not archive bulletins for not authorized user' do
    sign_in @second_author

    patch archive_bulletin_path(@draft)

    assert { @draft == @draft.reload }
    assert_redirected_to root_path
  end
end
