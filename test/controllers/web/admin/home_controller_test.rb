# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should show admin index' do
    sign_in users(:admin)

    get admin_root_path
    assert :success
  end

  test 'should not show admin index for not auth user' do
    get admin_root_path
    assert_redirected_to root_path
  end

  test 'should not show admin for not authorize user' do
    sign_in users(:first_author)

    get admin_root_path
    assert_redirected_to root_path
  end
end
