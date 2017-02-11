require 'test_helper'

class DestinationProfileActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @destination_profile_action = destination_profile_actions(:one)
  end

  test "should get index" do
    get destination_profile_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_destination_profile_action_url
    assert_response :success
  end

  test "should create destination_profile_action" do
    assert_difference('DestinationProfileAction.count') do
      post destination_profile_actions_url, params: { destination_profile_action: { application: @destination_profile_action.application, data: @destination_profile_action.data, destination_profile_id: @destination_profile_action.destination_profile_id } }
    end

    assert_redirected_to destination_profile_action_url(DestinationProfileAction.last)
  end

  test "should show destination_profile_action" do
    get destination_profile_action_url(@destination_profile_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_destination_profile_action_url(@destination_profile_action)
    assert_response :success
  end

  test "should update destination_profile_action" do
    patch destination_profile_action_url(@destination_profile_action), params: { destination_profile_action: { application: @destination_profile_action.application, data: @destination_profile_action.data, destination_profile_id: @destination_profile_action.destination_profile_id } }
    assert_redirected_to destination_profile_action_url(@destination_profile_action)
  end

  test "should destroy destination_profile_action" do
    assert_difference('DestinationProfileAction.count', -1) do
      delete destination_profile_action_url(@destination_profile_action)
    end

    assert_redirected_to destination_profile_actions_url
  end
end
