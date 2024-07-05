# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @under_moderate_bulletin = bulletins(:under_moderation)
        @archived_bulletin = bulletins(:archived)
        sign_in @admin
      end

      test 'should get index' do
        get admin_bulletins_url
        assert_response :success
      end

      test 'should publish bulletin' do
        patch publish_admin_bulletin_url(@under_moderate_bulletin)
        assert_redirected_to admin_root_path
        assert { @under_moderate_bulletin.reload.state == 'published' }
      end

      test 'should not publish bulletin if not allowed' do
        patch publish_admin_bulletin_url(@archived_bulletin)
        assert { @archived_bulletin.reload.state == 'archived' }
      end

      test 'should archive bulletin' do
        patch archive_admin_bulletin_url(@under_moderate_bulletin)
        assert_redirected_to admin_root_path
        assert { @archived_bulletin.reload.state == 'archived' }
      end

      test 'should reject bulletin' do
        patch reject_admin_bulletin_url(@under_moderate_bulletin)
        assert_redirected_to admin_root_path
        assert { @under_moderate_bulletin.reload.state == 'rejected' }
      end
    end
  end
end
