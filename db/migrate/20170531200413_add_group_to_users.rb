class AddGroupToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :user_group, foreign_key: true
  end
end
