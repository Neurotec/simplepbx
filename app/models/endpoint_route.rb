class EndpointRoute < ApplicationRecord
  belongs_to :endpoint
  has_many :endpoint_outbound_routes
  has_many :outbound_routes, class_name: 'OutboundRoute', through: :endpoint_outbound_routes
  
  validates :destination_number, presence: true, destination: true
  
  scope :from_user, ->(user) {where(endpoint_id: Endpoint.from_user(user).pluck(:id))}
  before_create do
    self.uuid = SecureRandom.uuid
  end
end
