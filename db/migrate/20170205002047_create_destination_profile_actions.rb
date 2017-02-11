class CreateDestinationProfileActions < ActiveRecord::Migration[5.0]
  def change
    create_table :destination_profile_actions do |t|
      t.references :destination_profile, foreign_key: true
      t.string :application
      t.string :data

      t.timestamps
    end
  end
end
