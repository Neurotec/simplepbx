class CreateFreeswitches < ActiveRecord::Migration[5.0]
  def change
    create_table :freeswitches do |t|
      t.string :host

      t.timestamps
    end
  end
end
