class AddCallcenterQueueToEndpointRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :endpoint_routes, :callcenter_queue_id, :integer
  end
end
