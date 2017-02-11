class CreateCallcenterQueues < ActiveRecord::Migration[5.0]
  def change
    create_table :callcenter_queues do |t|
      t.string :name
      t.string :uuid
      t.references :freeswitch, foreign_key: true
      t.string :strategy
      t.references :callcenter_queue_profile, foreign_key: true

      t.timestamps
    end
  end
end
