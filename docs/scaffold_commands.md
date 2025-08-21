# Scaffold Commands

bin/rails generate scaffold CongressionalDistrict \
  name:string \
  state_name:string\
  key_city:string \
  key_county:string \
  state:references \
  user:references

rails g scaffold PoliticalParty name:string fid:string url:string 
  create_table "political_parties", force: :cascade do |t|
    t.string "name"
    t.string "fid"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

rails g scaffold NewsClusterAssignment user:references news_feed_item:references news_cluster_term:references

rails g scaffold NewsClusterTerm user:references news_cluster:references term

rails g scaffold NewsCluster name:string user:references active:boolean


rails g scaffold GoogleSheetUrl name:string url:string options:text last_checked_at:datetime ip_address:string user_agent:string user:references

bin/rails generate scaffold NewsFeedItem \
  title:string \
  url:string:uniq \
  summary:text \
  published_at:datetime \
  guid:string:index \
  source:string \
  news_feed_url:references \
  image_url:string

rails g model FeedItem title:string url:string:uniq summary:text published_at:datetime guid:string:index image_url:string 
 "county","county_ascii","county_full","county_fips","state_id","state_name","lat","lng","population"
rails g scaffold name:string name_ascii:string name_full:string county_fips:string state:references state_abbreviation:string state_name:string lat:decimal lng:decimal coordinates:string population:integer 

#<City:0x00000001265d9108> {
              :id => 42515,
            :name => "Noblesville",
             :fid => "noblesville",
      :name_ascii => "Noblesville",
       :state_fid => "IN",
      :state_name => "Indiana",
     :county_fips => 18057,
     :county_name => "Hamilton",
             :lat => 40.0355,
             :lng => -86.0042,
     :coordinates => #<RGeo::Geographic::SphericalPointImpl:0x2d0c8 "POINT (40.0355 -86.0042)">,
      :population => 71940,
         :density => 787.5,
          :source => "shape",
        :military => false,
    :incorporated => true,
        :timezone => "America/Indiana/Indianapolis",
         :ranking => 3,
    :external_fid => 1840013891,
        :state_id => 15,
            :zips => nil,
      :created_at => 2025-08-12 06:24:28.099447000 UTC +00:00,
      :updated_at => 2025-08-12 06:24:28.099447000 UTC +00:00
      
      
rails g scaffold County  name:string state:references state_name:string population:integer county_fips:integer 

 city.county_name,
          state_name: city.state_name,
          state_id: city.state_id, 
          population: city.population,
          county_fips: city.county_fips,
          zips: city.zips,
          timezone: city.timezone 

rails g scaffold County name:string state_name:string state:references population:integer county_fips:integer zips:text timezone:string

rails g scaffold City name:string  fid:string name_ascii:string state_fid:string state_name:string county_fips:integer county_name:string lat:decimal lng:decimal coordinates:string population:integer density:decimal source:string military:boolean incorporated:boolean timezone:string ranking:integer external_fid:integer state:references zips:text

rails g scaffold City name:string  fid:string name_ascii:string state_fid:string state_name:string, county_fips:integer county_name:string lat:decimal lng:decimal coordinates:st_point population:integer density:decimal source:string military:boolean incorporated:boolean timezone:string ranking:integer external_fid:integer

rails g scaffold City name:string  fid:string name_ascii:string state_fid:string state_name:string county_fips:integer county_name:string lat:decimal lng:decimal coordinates:geometry population:integer density:decimal source:string military:boolean incorporated:boolean timezone:string ranking:integer external_fid:integer references:state zips:text

        name: row['city'],
        fid: row['city'].downcase.gsub(/ +/,'_'),
        ascii: row['city_ascii'],
        state_fid: row['state_id'],
        state_name: row['state_name'],
        county_fips: row['county_fips'],
        county_name: row['county_name'],
        lat: row['lat'],
        lng: row['lng'],
        population: row['population'], 
        density: row['density'],
        source: row['source'],
        military: row['military'],
        incorporated: row['incorporated'],
        timezone: row['timezone'],
        ranking: row['ranking'],
        external_fid: row['id']

rails g scaffold Events name:string event_type:references event_start_at:datetime event_end_at:datetime address1:string address2:string city:string state:references organization:references organization_fid:string slug:string fid:string congressional_district:references recurring:boolean recurrence:text url:string mobilize_url:string is_suggested_event:boolean pasted_description:text

rails g scaffold CongressionalDistricts name:string state:references important_city:string important_county:references 

  create_table "congressional_districts", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.string "key_city"
    t.string "key_county"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.string "state_name"
    t.index ["state_id"], name: "index_congressional_districts_on_state_id"
    t.index ["user_id"], name: "index_congressional_districts_on_user_id"
  end

rails g scaffold EventTypes name:string fid:string organization:references 



  create_table "events", force: :cascade do |t|
    t.string "name"
    t.bigint "event_type_id"
    t.date "date_start"
    t.date "date_end"
    t.time "time_start"
    t.time "time_end"
    t.string "location"
    t.bigint "share_code_id"
    t.bigint "organization_id"
    t.bigint "user_id"
    t.boolean "has_speakers"
    t.boolean "has_musicians"
    t.boolean "has_props"
    t.boolean "has_partners"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "active", default: true
    t.boolean "show_action_links", default: true
    t.string "fid"
    t.bigint "visibility_id"
    t.bigint "congressional_district_id"
    t.boolean "recurring", default: false
    t.text "recurrence"
    t.time "time_setup"
    t.time "time_teardown"
    t.string "secure_chat_url"
    t.string "web_url"
    t.string "goal"
    t.bigint "team_id"
    t.string "city"
    t.bigint "state_id"
    t.string "mobilize_url"
    t.boolean "is_suggested_event", default: false
    t.text "pasted_description"
    t.index ["congressional_district_id"], name: "index_events_on_congressional_district_id"
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["fid"], name: "index_events_on_fid"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["share_code_id"], name: "index_events_on_share_code_id"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["state_id"], name: "index_events_on_state_id"
    t.index ["team_id"], name: "index_events_on_team_id"
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["visibility_id"], name: "index_events_on_visibility_id"
  end

rails g scaffold Organization name:string fid:string active:boolean secure_chat_system:references billing:string city:string state:string organization_website_url:string organization_website_domain:string your_domain_or_ours:string domain:references sub_domain:string polly_domain:string polly_url:string features:text

rails g scaffold State name:string abbreviation:string fid:string population:integer congressional_district_count:integer wikipedia_congressional_district_url:string wikipedia_congressional_district_map_url:string counties_count:integer townships_count

rails g scaffold SecureChatSystem name:string fid:string url:string description:text