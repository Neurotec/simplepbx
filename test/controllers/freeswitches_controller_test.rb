require 'test_helper'

class FreeswitchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @freeswitch = freeswitches(:one)
  end

  test "should get index" do
    get freeswitches_url
    assert_response :success
  end

  test "should get new" do
    get new_freeswitch_url
    assert_response :success
  end

  test "should create freeswitch" do
    assert_difference('Freeswitch.count') do
      post freeswitches_url, params: { freeswitch: { host: @freeswitch.host } }
    end

    assert_redirected_to freeswitch_url(Freeswitch.last)
  end

  test "should show freeswitch" do
    get freeswitch_url(@freeswitch)
    assert_response :success
  end

  test "should get edit" do
    get edit_freeswitch_url(@freeswitch)
    assert_response :success
  end

  test "should update freeswitch" do
    patch freeswitch_url(@freeswitch), params: { freeswitch: { host: @freeswitch.host } }
    assert_redirected_to freeswitch_url(@freeswitch)
  end

  test "should destroy freeswitch" do
    assert_difference('Freeswitch.count', -1) do
      delete freeswitch_url(@freeswitch)
    end

    assert_redirected_to freeswitches_url
  end
end
