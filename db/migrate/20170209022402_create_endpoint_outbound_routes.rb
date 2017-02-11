class CreateEndpointOutboundRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :endpoint_outbound_routes do |t|
      t.references :outbound_route, foreign_key: true
      t.references :endpoint_route, foreign_key: true

      t.timestamps
    end
  end
end
