require 'test_helper'

class Resource::RecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource_record = resource_records(:one)
  end

  test "should get index" do
    get resource_records_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_record_url
    assert_response :success
  end

  test "should create resource_record" do
    assert_difference('Resource::Record.count') do
      post resource_records_url, params: { resource_record: { freeswitch_id: @resource_record.freeswitch_id, name: @resource_record.name, path: @resource_record.path } }
    end

    assert_redirected_to resource_record_url(Resource::Record.last)
  end

  test "should show resource_record" do
    get resource_record_url(@resource_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_record_url(@resource_record)
    assert_response :success
  end

  test "should update resource_record" do
    patch resource_record_url(@resource_record), params: { resource_record: { freeswitch_id: @resource_record.freeswitch_id, name: @resource_record.name, path: @resource_record.path } }
    assert_redirected_to resource_record_url(@resource_record)
  end

  test "should destroy resource_record" do
    assert_difference('Resource::Record.count', -1) do
      delete resource_record_url(@resource_record)
    end

    assert_redirected_to resource_records_url
  end
end
