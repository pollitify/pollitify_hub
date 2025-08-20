class HomeController < ApplicationController
  def index
    if cookies[:user_location] && 3 == 4
      location = JSON.parse(cookies[:user_location])
      city = location["city"]
      state = location["state"]
      # Use in searches
      #raise [city, state].inspect
      county, state_id = City.county(city, state)
      raise [county, state_id].inspect
      @events = Event.where(county: county, state_id: state_id).ordered_by_date
      raise @events.inspect
    end
    #raise [city, state].inspect
    
    state, city, county = SearchQuery.get_objects("fishers", "IN")  
    @events = Event.where(state_id: state.id, county_id: county.id).ordered_by_date
      #raise @events.inspect
      #@events = []
    @date = Date.today
    @news_feed_items = NewsFeedItem.ordered_by_date.page(params[:page]).per(NEWS_FEED_PAGINATION_COUNT)
  end
  
  def suggest
    @event = Event.new
  end
  
  def suggest_event_form
    @event = Event.new
    @states = State.ordered_by_name
  end
  
  def suggest_event_mobilize_url
    @event = Event.new
  end
  
  def suggest_event_paste_text
    @event = Event.new
  end
  
  def suggest_event_upload_flier
    @event = Event.new
  end
end
