class CreateOutbounds < ActiveRecord::Migration[5.0]
  def change
    create_table :outbounds do |t|
      t.references :endpoint, foreign_key: true
      t.string :name
      t.string :uuid
      t.string :realm
      t.string :username
      t.string :password
      t.boolean :register
      t.boolean :cidfrom
      t.string :codecs
      t.string :proxy
      t.string :cid_name
      t.string :cid_number
      t.timestamps
    end
  end
end
