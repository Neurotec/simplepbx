json.extract! endpoint_route, :id, :endpoint_id, :destination_number, :outbound_id, :inbound_id, :extension_id, :created_at, :updated_at
json.url endpoint_route_url(endpoint_route, format: :json)