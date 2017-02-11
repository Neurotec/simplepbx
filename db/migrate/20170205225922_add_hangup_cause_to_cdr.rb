class AddHangupCauseToCdr < ActiveRecord::Migration[5.0]
  def change
    add_column :cdrs, :hangup_cause, :string
  end
end
