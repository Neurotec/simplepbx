class CreateExtensionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :extension_groups do |t|
      t.references :extension, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
