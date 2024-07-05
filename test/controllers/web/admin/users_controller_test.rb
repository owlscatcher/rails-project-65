# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attr = {
      name: Faker::Name.name,
      admin: true
    }
  end

  test 'should show users index' do
    sign_in users(:admin)

    get admin_users_path
    assert :success
  end

  test 'should not show users index for not admin user' do
    sign_in users(:first_author)

    get admin_users_path
    assert_redirected_to root_path
  end
  test 'should update user for admin' do
    sign_in users(:admin)

    patch admin_user_path(users(:second_author)), params: { user: @attr }

    @user = User.find_by(@attr)
    assert { @user.name = @attr[:name] }
    assert { @user.admin = @attr[:admin] }
    assert_redirected_to admin_users_path
  end
end
