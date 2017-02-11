require 'test_helper'

class Callcenter::QueuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @callcenter_queue = callcenter_queues(:one)
  end

  test "should get index" do
    get callcenter_queues_url
    assert_response :success
  end

  test "should get new" do
    get new_callcenter_queue_url
    assert_response :success
  end

  test "should create callcenter_queue" do
    assert_difference('Callcenter::Queue.count') do
      post callcenter_queues_url, params: { callcenter_queue: { callcenter_queue_profile_id: @callcenter_queue.callcenter_queue_profile_id, name: @callcenter_queue.name, strategy: @callcenter_queue.strategy, uuid: @callcenter_queue.uuid } }
    end

    assert_redirected_to callcenter_queue_url(Callcenter::Queue.last)
  end

  test "should show callcenter_queue" do
    get callcenter_queue_url(@callcenter_queue)
    assert_response :success
  end

  test "should get edit" do
    get edit_callcenter_queue_url(@callcenter_queue)
    assert_response :success
  end

  test "should update callcenter_queue" do
    patch callcenter_queue_url(@callcenter_queue), params: { callcenter_queue: { callcenter_queue_profile_id: @callcenter_queue.callcenter_queue_profile_id, name: @callcenter_queue.name, strategy: @callcenter_queue.strategy, uuid: @callcenter_queue.uuid } }
    assert_redirected_to callcenter_queue_url(@callcenter_queue)
  end

  test "should destroy callcenter_queue" do
    assert_difference('Callcenter::Queue.count', -1) do
      delete callcenter_queue_url(@callcenter_queue)
    end

    assert_redirected_to callcenter_queues_url
  end
end
