class DestinationProfile < ApplicationRecord
  belongs_to :endpoint
  has_many :actions, class_name: 'DestinationProfileAction'

  scope :from_user, ->(user) {where(endpoint_id: Endpoint.from_user(user).pluck(:id))}
  
  before_create do
    self.uuid = SecureRandom.uuid
  end
  
end
