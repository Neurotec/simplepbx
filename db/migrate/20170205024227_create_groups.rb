class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.references :endpoint, foreign_key: true
      t.string :name
      t.string :uuid
      t.timestamps
    end
  end
end
