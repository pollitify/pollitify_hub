json.extract! government_official, :id, :full_name, :first_name, :middle_name, :last_name, :title, :phone_number, :email_link, :full_address, :address1, :address2, :city, :state, :zip, :state_id, :government_official_type_id, :committees, :created_at, :updated_at
json.url government_official_url(government_official, format: :json)
