require 'test_helper'

class InboundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inbound = inbounds(:one)
  end

  test "should get index" do
    get inbounds_url
    assert_response :success
  end

  test "should get new" do
    get new_inbound_url
    assert_response :success
  end

  test "should create inbound" do
    assert_difference('Inbound.count') do
      post inbounds_url, params: { inbound: { endpoint_id: @inbound.endpoint_id, host: @inbound.host, name: @inbound.name, password: @inbound.password, register: @inbound.register, username: @inbound.username } }
    end

    assert_redirected_to inbound_url(Inbound.last)
  end

  test "should show inbound" do
    get inbound_url(@inbound)
    assert_response :success
  end

  test "should get edit" do
    get edit_inbound_url(@inbound)
    assert_response :success
  end

  test "should update inbound" do
    patch inbound_url(@inbound), params: { inbound: { endpoint_id: @inbound.endpoint_id, host: @inbound.host, name: @inbound.name, password: @inbound.password, register: @inbound.register, username: @inbound.username } }
    assert_redirected_to inbound_url(@inbound)
  end

  test "should destroy inbound" do
    assert_difference('Inbound.count', -1) do
      delete inbound_url(@inbound)
    end

    assert_redirected_to inbounds_url
  end
end
