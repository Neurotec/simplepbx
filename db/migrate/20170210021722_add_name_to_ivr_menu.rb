class AddNameToIvrMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :ivr_menus, :name, :string
  end
end
