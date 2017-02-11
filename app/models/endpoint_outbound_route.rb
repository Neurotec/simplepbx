class EndpointOutboundRoute < ApplicationRecord
  belongs_to :outbound_route
  belongs_to :endpoint_route
end
