class AddRecordPublicKeyToFreeswitch < ActiveRecord::Migration[5.0]
  def change
    add_column :freeswitches, :record_public_user, :string, default: "simplepbx_recording"
  end
end
