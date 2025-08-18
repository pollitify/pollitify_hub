json.extract! google_sheet_url, :id, :name, :url, :options, :last_checked_at, :ip_address, :user_agent, :user_id, :created_at, :updated_at
json.url google_sheet_url_url(google_sheet_url, format: :json)
