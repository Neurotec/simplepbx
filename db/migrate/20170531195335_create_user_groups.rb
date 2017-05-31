class CreateUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups do |t|
      t.string :name
      t.references :group_permissions, foreign_key: true

      t.timestamps
    end
  end
end
