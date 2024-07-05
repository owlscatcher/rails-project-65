# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'should be authenticated first' do
    get profile_path
    assert_response :redirect
  end

  test 'should get show' do
    sign_in users(:first_author)
    get profile_path
    assert_response :success
  end
end
