require 'test_helper'

class Ivr::MenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ivr_menu = ivr_menus(:one)
  end

  test "should get index" do
    get ivr_menus_url
    assert_response :success
  end

  test "should get new" do
    get new_ivr_menu_url
    assert_response :success
  end

  test "should create ivr_menu" do
    assert_difference('Ivr::Menu.count') do
      post ivr_menus_url, params: { ivr_menu: { digit_len: @ivr_menu.digit_len, exit_sound_id: @ivr_menu.exit_sound_id, greet_long_id: @ivr_menu.greet_long_id, greet_short_id: @ivr_menu.greet_short_id, inter_digit_timeout=2000: @ivr_menu.inter_digit_timeout=2000, invalid_sound_id: @ivr_menu.invalid_sound_id, max_failures=integer: @ivr_menu.max_failures=integer, menu_top_digits: @ivr_menu.menu_top_digits, timeout: @ivr_menu.timeout } }
    end

    assert_redirected_to ivr_menu_url(Ivr::Menu.last)
  end

  test "should show ivr_menu" do
    get ivr_menu_url(@ivr_menu)
    assert_response :success
  end

  test "should get edit" do
    get edit_ivr_menu_url(@ivr_menu)
    assert_response :success
  end

  test "should update ivr_menu" do
    patch ivr_menu_url(@ivr_menu), params: { ivr_menu: { digit_len: @ivr_menu.digit_len, exit_sound_id: @ivr_menu.exit_sound_id, greet_long_id: @ivr_menu.greet_long_id, greet_short_id: @ivr_menu.greet_short_id, inter_digit_timeout=2000: @ivr_menu.inter_digit_timeout=2000, invalid_sound_id: @ivr_menu.invalid_sound_id, max_failures=integer: @ivr_menu.max_failures=integer, menu_top_digits: @ivr_menu.menu_top_digits, timeout: @ivr_menu.timeout } }
    assert_redirected_to ivr_menu_url(@ivr_menu)
  end

  test "should destroy ivr_menu" do
    assert_difference('Ivr::Menu.count', -1) do
      delete ivr_menu_url(@ivr_menu)
    end

    assert_redirected_to ivr_menus_url
  end
end
