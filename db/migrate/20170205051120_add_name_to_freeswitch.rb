class AddNameToFreeswitch < ActiveRecord::Migration[5.0]
  def change
    add_column :freeswitches, :name, :string
  end
end
