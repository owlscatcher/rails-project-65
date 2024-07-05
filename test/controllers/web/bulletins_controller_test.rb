# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:draft)
    @author = users(:author)

    @attr = {
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      image: fixture_file_upload('1.jpg', 'image/jpg'),
      category_id: categories(:one).id
    }

    @image = fixture_file_upload('1.jpg', 'image/jpg')
    @bulletin.image.attach(@image)
  end

  test 'should get root' do
    get root_path
    assert_response :success
  end

  test 'should get new' do
    sign_in @author

    get new_bulletin_path
    assert_response :success
  end

  test 'should not get new for not signed users' do
    get new_bulletin_url

    assert_redirected_to root_url
  end

  test 'should create new bulletins' do
    sign_in @author

    post bulletins_url, params: { bulletin: @attr }

    bulletin = Bulletin.find_by(@attr.except(:image))
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end

  test 'should update bulletin' do
    sign_in @author

    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title == @attrs[:title] }
    assert { @bulletin.description == @attrs[:description] }
    assert_redirected_to profile_url
  end

  # test 'should not create new bulletin for logout user' do
  #   post bulletins_url, params: { bulletin: @attr }

  #   bulletin = Bulletin.find_by(@attr.except(:image))
  #   assert { bulletin.nil? }
  #   assert_redirected_to root_path
  # end

  test 'should archive bulletins' do
    sign_in @user

    patch archive_bulletin_path(@bulletin_draft)

    @bulletin_draft.reload
    assert @bulletin_draft.archived?
  end
end
