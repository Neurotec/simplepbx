class CreateOutboundRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :outbound_routes do |t|
      t.string :foreign_class_name
      t.integer :foreign_id, index: true
      t.timestamps
    end
  end
end
