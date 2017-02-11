require 'test_helper'

class ExtensionGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extension_group = extension_groups(:one)
  end

  test "should get index" do
    get extension_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_extension_group_url
    assert_response :success
  end

  test "should create extension_group" do
    assert_difference('ExtensionGroup.count') do
      post extension_groups_url, params: { extension_group: { extension_id: @extension_group.extension_id, group_id: @extension_group.group_id } }
    end

    assert_redirected_to extension_group_url(ExtensionGroup.last)
  end

  test "should show extension_group" do
    get extension_group_url(@extension_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_extension_group_url(@extension_group)
    assert_response :success
  end

  test "should update extension_group" do
    patch extension_group_url(@extension_group), params: { extension_group: { extension_id: @extension_group.extension_id, group_id: @extension_group.group_id } }
    assert_redirected_to extension_group_url(@extension_group)
  end

  test "should destroy extension_group" do
    assert_difference('ExtensionGroup.count', -1) do
      delete extension_group_url(@extension_group)
    end

    assert_redirected_to extension_groups_url
  end
end
