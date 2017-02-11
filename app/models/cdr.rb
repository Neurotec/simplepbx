class Cdr < ApplicationRecord
  belongs_to :freeswitch

  validates :destination_number, destination: true

  def start_time
    Time.at(start_epoch).strftime("%Y-%m-%d %H:%M:%S %z")
  end
end
