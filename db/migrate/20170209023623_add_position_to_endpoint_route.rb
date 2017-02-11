class AddPositionToEndpointRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :endpoint_routes, :position, :integer, default: 0
  end
end
