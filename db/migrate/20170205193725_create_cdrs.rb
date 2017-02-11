class CreateCdrs < ActiveRecord::Migration[5.0]
  def change
    create_table :cdrs do |t|
      t.references :freeswitch, foreign_key: true
      t.string :call_uuid
      t.string :caller_id_name
      t.string :caller_id_number
      t.string :destination_number
      t.string :record_path
      t.integer :start_epoch
      t.integer :duration
      t.integer :hangup_cause_q850

      t.timestamps
    end
  end
end
