class CreateDestinationProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :destination_profiles do |t|
      t.references :endpoint, foreign_key: true
      t.string :type
      t.string :name
      t.string :uuid
      t.string :condition_field
      t.string :condition_expression

      t.timestamps
    end
  end
end
