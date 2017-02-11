class CreateEndpointRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :endpoint_routes do |t|
      t.integer :endpoint_id
      t.string :destination_number
      t.integer :outbound_id
      t.integer :inbound_id
      t.integer :extension_id

      t.timestamps
    end
  end
end
