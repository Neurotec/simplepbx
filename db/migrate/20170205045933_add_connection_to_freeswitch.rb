class AddConnectionToFreeswitch < ActiveRecord::Migration[5.0]
  def change
    add_column :freeswitches, :event_socket_port, :integer, default: 8021
    add_column :freeswitches, :event_socket_password, :string, default: 'ClueCon'
  end
end
