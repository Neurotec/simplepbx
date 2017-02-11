require 'test_helper'

class Callcenter::TiersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @callcenter_tier = callcenter_tiers(:one)
  end

  test "should get index" do
    get callcenter_tiers_url
    assert_response :success
  end

  test "should get new" do
    get new_callcenter_tier_url
    assert_response :success
  end

  test "should create callcenter_tier" do
    assert_difference('Callcenter::Tier.count') do
      post callcenter_tiers_url, params: { callcenter_tier: { callcenter_queue_id: @callcenter_tier.callcenter_queue_id, extension_id: @callcenter_tier.extension_id, level: @callcenter_tier.level, position: @callcenter_tier.position } }
    end

    assert_redirected_to callcenter_tier_url(Callcenter::Tier.last)
  end

  test "should show callcenter_tier" do
    get callcenter_tier_url(@callcenter_tier)
    assert_response :success
  end

  test "should get edit" do
    get edit_callcenter_tier_url(@callcenter_tier)
    assert_response :success
  end

  test "should update callcenter_tier" do
    patch callcenter_tier_url(@callcenter_tier), params: { callcenter_tier: { callcenter_queue_id: @callcenter_tier.callcenter_queue_id, extension_id: @callcenter_tier.extension_id, level: @callcenter_tier.level, position: @callcenter_tier.position } }
    assert_redirected_to callcenter_tier_url(@callcenter_tier)
  end

  test "should destroy callcenter_tier" do
    assert_difference('Callcenter::Tier.count', -1) do
      delete callcenter_tier_url(@callcenter_tier)
    end

    assert_redirected_to callcenter_tiers_url
  end
end
