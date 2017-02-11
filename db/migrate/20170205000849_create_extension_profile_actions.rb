class CreateExtensionProfileActions < ActiveRecord::Migration[5.0]
  def change
    create_table :extension_profile_actions do |t|
      t.references :extension_profile, foreign_key: true
      t.integer :priority, default: 0
      t.string :application
      t.string :data

      t.timestamps
    end
  end
end
