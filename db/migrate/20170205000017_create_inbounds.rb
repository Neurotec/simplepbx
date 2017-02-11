class CreateInbounds < ActiveRecord::Migration[5.0]
  def change
    create_table :inbounds do |t|
      t.references :endpoint, foreign_key: true
      t.string :name
      t.string :uuid
      t.string :host
      t.string :username
      t.string :password
      t.boolean :register
      t.string :cid_name, default: '$${outbound_caller_id_name}'
      t.string :cid_number, default: '$${outbound_caller_id_number}'
      t.timestamps
    end
  end
end
