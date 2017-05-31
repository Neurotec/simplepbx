class CreateIvrActions < ActiveRecord::Migration[5.0]
  def change
    create_table :ivr_actions do |t|
      t.references :ivr_menu, foreign_key: true
      t.references :outbound_route, foreign_key: true
      t.integer :digits

      t.timestamps
    end
  end
end
