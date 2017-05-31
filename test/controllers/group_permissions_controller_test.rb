require 'test_helper'

class GroupPermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_permission = group_permissions(:one)
  end

  test "should get index" do
    get group_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_group_permission_url
    assert_response :success
  end

  test "should create group_permission" do
    assert_difference('GroupPermission.count') do
      post group_permissions_url, params: { group_permission: { allow_create: @group_permission.allow_create, allow_delete: @group_permission.allow_delete, allow_read: @group_permission.allow_read, allow_update: @group_permission.allow_update, description: @group_permission.description, name: @group_permission.name } }
    end

    assert_redirected_to group_permission_url(GroupPermission.last)
  end

  test "should show group_permission" do
    get group_permission_url(@group_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_permission_url(@group_permission)
    assert_response :success
  end

  test "should update group_permission" do
    patch group_permission_url(@group_permission), params: { group_permission: { allow_create: @group_permission.allow_create, allow_delete: @group_permission.allow_delete, allow_read: @group_permission.allow_read, allow_update: @group_permission.allow_update, description: @group_permission.description, name: @group_permission.name } }
    assert_redirected_to group_permission_url(@group_permission)
  end

  test "should destroy group_permission" do
    assert_difference('GroupPermission.count', -1) do
      delete group_permission_url(@group_permission)
    end

    assert_redirected_to group_permissions_url
  end
end
