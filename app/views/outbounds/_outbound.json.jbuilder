json.extract! outbound, :id, :endpoint_id, :name, :realm, :username, :password, :register, :cidfrom, :codecs, :proxy, :created_at, :updated_at
json.url outbound_url(outbound, format: :json)