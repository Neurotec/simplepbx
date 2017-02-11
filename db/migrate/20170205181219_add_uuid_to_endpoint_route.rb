class AddUuidToEndpointRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :endpoint_routes, :uuid, :string
  end
end
