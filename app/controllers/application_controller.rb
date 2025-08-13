class ApplicationController < ActionController::Base
  require 'net/http'
  require 'json'
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :set_location
  
  private

   def set_location
     return if cookies[:user_location].present?

     ip = request.remote_ip
     # For local dev, you might want to override:
     ip = "8.8.8.8" if ip == "127.0.0.1" || ip == "::1"
     ip = "66.249.66.42" if Rails.env.development?

     uri = URI("http://ip-api.com/json/#{ip}")
     res = Net::HTTP.get(uri)
     data = JSON.parse(res) rescue {}

     if data["status"] == "success"
       @inferred_city  = data["city"]
       @inferred_state = data["regionName"]
     else
       @inferred_city = @inferred_state = nil
     end
   end
end
