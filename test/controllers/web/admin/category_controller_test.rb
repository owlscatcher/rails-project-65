# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @not_admin = users(:first_author)
    @create_params = { category: { name: 'Name' } }
    @update_params = { category: { name: 'New Category Name' } }
    @category = categories(:one)
  end

  test 'should get index' do
    get admin_categories_url
    assert_redirected_to root_path
  end

  test 'admin should create category' do
    sign_in @admin

    post admin_categories_url, params: @create_params

    category = Category.find_by(name: @create_params[:category][:name])
    assert { category.name == @create_params[:category][:name] }
    assert_redirected_to admin_categories_url
  end

  test 'admin should update category' do
    sign_in @admin

    patch admin_category_path(@category), params: @update_params

    category = Category.find_by(name: @update_params[:category][:name])
    assert { category.name == @update_params[:category][:name] }
    assert_redirected_to admin_categories_url
  end
end
