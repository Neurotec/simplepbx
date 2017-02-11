class CreateExtensions < ActiveRecord::Migration[5.0]
  def change
    create_table :extensions do |t|
      t.references :endpoint, foreign_key: true
      t.string :username
      t.string :password
      t.integer :vmpassword
      t.string :cid_name, default: ''
      t.string :cid_number, default: ''
      t.string :location
      t.references :extension_profile, foreign_key: true

      t.timestamps
    end
  end
end
