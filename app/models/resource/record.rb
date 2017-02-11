class Resource::Record < ApplicationRecord
  include Audible
  audible_freeswitch_ref [:freeswitch, :id]
  
  belongs_to :freeswitch

  def audible_name
    "Record(#{freeswitch.name}@#{name})"
  end
end
