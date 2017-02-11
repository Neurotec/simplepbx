require 'test_helper'

class ExtensionProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extension_profile = extension_profiles(:one)
  end

  test "should get index" do
    get extension_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_extension_profile_url
    assert_response :success
  end

  test "should create extension_profile" do
    assert_difference('ExtensionProfile.count') do
      post extension_profiles_url, params: { extension_profile: { name: @extension_profile.name } }
    end

    assert_redirected_to extension_profile_url(ExtensionProfile.last)
  end

  test "should show extension_profile" do
    get extension_profile_url(@extension_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_extension_profile_url(@extension_profile)
    assert_response :success
  end

  test "should update extension_profile" do
    patch extension_profile_url(@extension_profile), params: { extension_profile: { name: @extension_profile.name } }
    assert_redirected_to extension_profile_url(@extension_profile)
  end

  test "should destroy extension_profile" do
    assert_difference('ExtensionProfile.count', -1) do
      delete extension_profile_url(@extension_profile)
    end

    assert_redirected_to extension_profiles_url
  end
end
