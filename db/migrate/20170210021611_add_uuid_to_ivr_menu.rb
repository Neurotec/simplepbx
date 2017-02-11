class AddUuidToIvrMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :ivr_menus, :uuid, :string
  end
end
