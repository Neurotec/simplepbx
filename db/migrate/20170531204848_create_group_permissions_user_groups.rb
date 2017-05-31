class CreateGroupPermissionsUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :group_permissions_user_groups do |t|
      t.belongs_to :group_permission
      t.belongs_to :user_group
    end
  end
end
