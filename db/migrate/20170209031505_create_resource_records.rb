class CreateResourceRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_records do |t|
      t.references :freeswitch, foreign_key: true
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
