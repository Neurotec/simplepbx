json.extract! resource_record, :id, :freeswitch_id, :name, :path, :created_at, :updated_at
json.url resource_record_url(resource_record, format: :json)