class LocationsController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: :set_location

  def set_location
    cookies[:user_location] = {
      value: { city: params[:city], state: params[:state] }.to_json,
      expires: 1.year.from_now
    }
    head :ok
  end
  
end
