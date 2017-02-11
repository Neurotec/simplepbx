require 'test_helper'

class ExtensionProfileActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extension_profile_action = extension_profile_actions(:one)
  end

  test "should get index" do
    get extension_profile_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_extension_profile_action_url
    assert_response :success
  end

  test "should create extension_profile_action" do
    assert_difference('ExtensionProfileAction.count') do
      post extension_profile_actions_url, params: { extension_profile_action: { application: @extension_profile_action.application, data: @extension_profile_action.data, extension_profile_id: @extension_profile_action.extension_profile_id, order: @extension_profile_action.order } }
    end

    assert_redirected_to extension_profile_action_url(ExtensionProfileAction.last)
  end

  test "should show extension_profile_action" do
    get extension_profile_action_url(@extension_profile_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_extension_profile_action_url(@extension_profile_action)
    assert_response :success
  end

  test "should update extension_profile_action" do
    patch extension_profile_action_url(@extension_profile_action), params: { extension_profile_action: { application: @extension_profile_action.application, data: @extension_profile_action.data, extension_profile_id: @extension_profile_action.extension_profile_id, order: @extension_profile_action.order } }
    assert_redirected_to extension_profile_action_url(@extension_profile_action)
  end

  test "should destroy extension_profile_action" do
    assert_difference('ExtensionProfileAction.count', -1) do
      delete extension_profile_action_url(@extension_profile_action)
    end

    assert_redirected_to extension_profile_actions_url
  end
end
