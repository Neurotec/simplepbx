require 'test_helper'

class OutboundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outbound = outbounds(:one)
  end

  test "should get index" do
    get outbounds_url
    assert_response :success
  end

  test "should get new" do
    get new_outbound_url
    assert_response :success
  end

  test "should create outbound" do
    assert_difference('Outbound.count') do
      post outbounds_url, params: { outbound: { cidfrom: @outbound.cidfrom, codecs: @outbound.codecs, endpoint_id: @outbound.endpoint_id, name: @outbound.name, password: @outbound.password, proxy: @outbound.proxy, realm: @outbound.realm, register: @outbound.register, username: @outbound.username } }
    end

    assert_redirected_to outbound_url(Outbound.last)
  end

  test "should show outbound" do
    get outbound_url(@outbound)
    assert_response :success
  end

  test "should get edit" do
    get edit_outbound_url(@outbound)
    assert_response :success
  end

  test "should update outbound" do
    patch outbound_url(@outbound), params: { outbound: { cidfrom: @outbound.cidfrom, codecs: @outbound.codecs, endpoint_id: @outbound.endpoint_id, name: @outbound.name, password: @outbound.password, proxy: @outbound.proxy, realm: @outbound.realm, register: @outbound.register, username: @outbound.username } }
    assert_redirected_to outbound_url(@outbound)
  end

  test "should destroy outbound" do
    assert_difference('Outbound.count', -1) do
      delete outbound_url(@outbound)
    end

    assert_redirected_to outbounds_url
  end
end
