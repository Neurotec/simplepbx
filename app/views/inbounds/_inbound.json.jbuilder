json.extract! inbound, :id, :endpoint_id, :name, :host, :username, :password, :register, :created_at, :updated_at
json.url inbound_url(inbound, format: :json)