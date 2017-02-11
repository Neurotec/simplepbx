class AddXmlrpCtoFreeswitch < ActiveRecord::Migration[5.0]
  def change
    add_column :freeswitches, :xml_rpc_realm, :string, default: 'freeswitch'
    add_column :freeswitches, :xml_rpc_user, :string, default: 'freeswitch'
    add_column :freeswitches, :xml_rpc_pass, :string, default: 'works'
    add_column :freeswitches, :xml_rpc_port, :integer, default: 8080
  end
end
