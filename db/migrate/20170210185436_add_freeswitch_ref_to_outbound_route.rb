class AddFreeswitchRefToOutboundRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :outbound_routes, :freeswitch_id, :integer
  end
end
