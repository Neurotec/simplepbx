class CreateCallcenterQueueProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :callcenter_queue_profiles do |t|
      t.string :type
      t.string :name, default: "General"
      t.string :moh_sound, default: "$${hold_music}" #TODO
      t.string :time_base_score, default: "queue"
      t.boolean :tier_rules_apply, default: false
      t.integer :tier_rule_wait_second, default: 300
      t.boolean :tier_rule_wait_multiply_level, default: true
      t.boolean :tier_rule_no_agent_no_wait, default: false
      t.integer :discard_abandoned_after, default: 14400
      t.boolean :abandoned_resume_allowed, default: false
      t.integer :max_wait_time, default: 0
      t.integer :max_wait_time_with_no_agent, default: 120

      t.timestamps
    end
  end
end
