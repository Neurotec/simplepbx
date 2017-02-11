class Callcenter::Tier < ApplicationRecord
  belongs_to :extension
  belongs_to :callcenter_queue, class_name: 'Callcenter::Queue', foreign_key: 'callcenter_queue_id'

end
