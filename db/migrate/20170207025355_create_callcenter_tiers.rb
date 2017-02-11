class CreateCallcenterTiers < ActiveRecord::Migration[5.0]
  def change
    create_table :callcenter_tiers do |t|
      t.references :extension, foreign_key: true
      t.references :callcenter_queue, foreign_key: true
      t.integer :level, default: 1
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
