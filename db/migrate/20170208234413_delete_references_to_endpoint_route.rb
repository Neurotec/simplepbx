class DeleteReferencesToEndpointRoute < ActiveRecord::Migration[5.0]
  def change
    remove_column :endpoint_routes, :outbound_id, :integer
    remove_column :endpoint_routes, :extension_id, :integer
    remove_column :endpoint_routes, :group_id, :integer
    remove_column :endpoint_routes, :callcenter_queue_id, :integer
  end
end
