class CreateEndpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :endpoints do |t|
      t.references :freeswitch, foreign_key: true
      t.string :uuid
      t.string :address
      t.integer :port
      t.string :external_address
      t.timestamps
    end
  end
end
