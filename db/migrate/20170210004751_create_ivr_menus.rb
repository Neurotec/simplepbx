class CreateIvrMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :ivr_menus do |t|
      #referencias a resource_object
      t.integer :greet_long_id
      t.integer :greet_short_id
      t.integer :invalid_sound_id
      t.integer :exit_sound_id
      
      t.integer :timeout, default: 10000
      t.integer:inter_digit_timeout, default: 2000
      t.integer :max_failures, default: 3
      t.integer :digit_len, default: 4
      t.integer :menu_top_digits, default: 9

      t.timestamps
    end
  end
end
