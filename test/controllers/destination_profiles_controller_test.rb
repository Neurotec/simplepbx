require 'test_helper'

class DestinationProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @destination_profile = destination_profiles(:one)
  end

  test "should get index" do
    get destination_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_destination_profile_url
    assert_response :success
  end

  test "should create destination_profile" do
    assert_difference('DestinationProfile.count') do
      post destination_profiles_url, params: { destination_profile: { condition_expression: @destination_profile.condition_expression, condition_field: @destination_profile.condition_field, name: @destination_profile.name } }
    end

    assert_redirected_to destination_profile_url(DestinationProfile.last)
  end

  test "should show destination_profile" do
    get destination_profile_url(@destination_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_destination_profile_url(@destination_profile)
    assert_response :success
  end

  test "should update destination_profile" do
    patch destination_profile_url(@destination_profile), params: { destination_profile: { condition_expression: @destination_profile.condition_expression, condition_field: @destination_profile.condition_field, name: @destination_profile.name } }
    assert_redirected_to destination_profile_url(@destination_profile)
  end

  test "should destroy destination_profile" do
    assert_difference('DestinationProfile.count', -1) do
      delete destination_profile_url(@destination_profile)
    end

    assert_redirected_to destination_profiles_url
  end
end
