class CreateGroupPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :group_permissions do |t|
      t.string :name
      t.string :description
      t.boolean :allow_create
      t.boolean :allow_read
      t.boolean :allow_update
      t.boolean :allow_delete

      t.timestamps
    end
  end
end
