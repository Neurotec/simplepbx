class AddFreeswitchToIvrMenu < ActiveRecord::Migration[5.0]
  def change
    add_reference :ivr_menus, :freeswitch, foreign_key: true
  end
end
