class AddFreeswitchRefToResourceObject < ActiveRecord::Migration[5.0]
  def change
    add_column :resource_objects, :freeswitch_id, :integer
  end
end
