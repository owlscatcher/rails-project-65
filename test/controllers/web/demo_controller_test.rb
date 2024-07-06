# frozen_string_literal: true

require 'test_helper'

class Web::DemoControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:first_author)
    @admin = users(:admin)
  end

  test 'should upgraded access control' do
    sign_in @user

    patch change_access_path

    assert { @user.reload.admin? }
  end

  test 'should downgraded access control' do
    sign_in @admin

    patch change_access_path

    assert { !@admin.reload.admin? }
  end
end
