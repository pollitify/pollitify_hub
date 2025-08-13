json.extract! event, :id, :name, :event_type_id, :event_start_at, :event_end_at, :address1, :address2, :city, :state_id, :organization_id, :organization_fid, :slug, :fid, :congressional_district_id, :recurring, :recurrence, :url, :mobilize_url, :is_suggested_event, :pasted_description, :created_at, :updated_at
json.url event_url(event, format: :json)
