class AddGroupToEndpointRoute < ActiveRecord::Migration[5.0]
  def change
    add_reference :endpoint_routes, :group, foreign_key: true
  end
end
