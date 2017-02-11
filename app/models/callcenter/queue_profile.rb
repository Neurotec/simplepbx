class Callcenter::QueueProfile < ApplicationRecord
  validates :name, name: true
  def to_s; name end
end
