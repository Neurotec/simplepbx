class AddDoRecordToExtension < ActiveRecord::Migration[5.0]
  def change
    add_column :extensions, :do_record, :boolean, default: false
  end
end
