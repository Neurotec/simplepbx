require 'test_helper'

class EndpointRoutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint_route = endpoint_routes(:one)
  end

  test "should get index" do
    get endpoint_routes_url
    assert_response :success
  end

  test "should get new" do
    get new_endpoint_route_url
    assert_response :success
  end

  test "should create endpoint_route" do
    assert_difference('EndpointRoute.count') do
      post endpoint_routes_url, params: { endpoint_route: { destination_number: @endpoint_route.destination_number, endpoint_id: @endpoint_route.endpoint_id, extension_id: @endpoint_route.extension_id, inbound_id: @endpoint_route.inbound_id, outbound_id: @endpoint_route.outbound_id } }
    end

    assert_redirected_to endpoint_route_url(EndpointRoute.last)
  end

  test "should show endpoint_route" do
    get endpoint_route_url(@endpoint_route)
    assert_response :success
  end

  test "should get edit" do
    get edit_endpoint_route_url(@endpoint_route)
    assert_response :success
  end

  test "should update endpoint_route" do
    patch endpoint_route_url(@endpoint_route), params: { endpoint_route: { destination_number: @endpoint_route.destination_number, endpoint_id: @endpoint_route.endpoint_id, extension_id: @endpoint_route.extension_id, inbound_id: @endpoint_route.inbound_id, outbound_id: @endpoint_route.outbound_id } }
    assert_redirected_to endpoint_route_url(@endpoint_route)
  end

  test "should destroy endpoint_route" do
    assert_difference('EndpointRoute.count', -1) do
      delete endpoint_route_url(@endpoint_route)
    end

    assert_redirected_to endpoint_routes_url
  end
end
