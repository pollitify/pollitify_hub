json.extract! post, :id, :user_id, :content, :post_type, :verified, :points_earned, :activity_date, :location, :created_at, :updated_at
json.url post_url(post, format: :json)
