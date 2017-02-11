class AddUserRefToFreeswitch < ActiveRecord::Migration[5.0]
  def change
    add_reference :freeswitches, :user, foreign_key: true
  end
end
