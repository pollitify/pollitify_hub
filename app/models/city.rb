class City < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :county, optional: true
  
  has_many :events
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  # https://claude.ai/chat/6fd2f414-6cdb-4d26-89a8-14d633f2b2e4
  # Set the factory for the coordinates attribute
  # self.rgeo_factory_for_column = {
  #   coordinates: RGeo::Geographic.spherical_factory(srid: 4326)
  # }
  # NoMethodError: undefined method 'rgeo_factory_for_column=' for class City (NoMethodError)
#   /
#

  # RGeo factory for spherical (Earth-like) coordinates
  FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  #before_validation :set_coordinates_from_lat_lng

  # Find cities within a radius (miles) of this city
  # def nearby(radius_miles)
  #   return City.none unless coordinates
  #
  #   radius_meters = radius_miles * 1609.34
  #
  #  City
  #    .select("cities.*, ST_Distance(coordinates, :point) AS distance")
  #    .where.not(id: id)
  #    .where("ST_DWithin(coordinates, :point, :radius)", point: coordinates, radius: radius_meters)
  #    .order("distance ASC")
  #    .bind_params(point: coordinates, radius: radius_meters) # Rails 8 param binding
  # end
  
  # Nearby method — distance in miles
  # def nearby(radius_miles)
  #   # PostGIS ST_DWithin uses meters
  #   radius_meters = radius_miles * 1609.34
  #
  #   City.where.not(id: id)
  #       .where(
  #         "ST_DWithin(cities.coordinates, ?, ?)",
  #         coordinates,
  #         radius_meters
  #       )
  #       .order(
  #         Arel.sql("ST_Distance(cities.coordinates, ST_GeogFromText('SRID=4326;POINT(#{lng} #{lat})')) ASC")
  #       )
  # end
  
  def self.county(city_name, state_abbreviation)
    state = State.abbreviation(state_abbreviation)
    result = City.where(name: city_name.capitalize, state_id: state.id).first
    return result.try(:county), result.try(:state_id)
  end
  
  # Nearby search
   # radius_miles: distance in miles
   def nearby(radius_miles)
     return City.none unless coordinates

     # Convert miles to meters
     radius_meters = radius_miles * 1609.34
     debugger
     City
       .where.not(id: id)
       .where(
         City.sanitize_sql_for_conditions([
           "ST_DWithin(coordinates, ST_GeographyFromText(?), ?)",
           "SRID=4326;POINT(#{lng} #{lat})",
           radius_meters
         ])
       )
       .select(
         "cities.*, ST_Distance(coordinates, ST_GeographyFromText('SRID=4326;POINT(#{lng} #{lat})')) AS distance_meters"
       )
       .order("distance_meters ASC")
   end
  

  def self.get_boolean(val)
    return false if val == "FALSE"
    return true if val == "TRUE"
  end
  
  def nearby_cities(miles)
  end
  
  def self.fishers
    City.where(name: "Fishers", state_name: "Indiana").first
  end

  def self.f
    City.where(name: "Fishers", state_name: "Indiana").first
  end

  def self.noblesville
    City.where(name: "Noblesville", state_name: "Indiana").first
  end
  
  def self.n
    City.where(name: "Noblesville", state_name: "Indiana").first
  end

  def self.indianapolis
    City.where(name: "Indianapolis", state_name: "Indiana").first
  end
  
  def self.indy
    City.where(name: "Indianapolis", state_name: "Indiana").first
  end
  
  def self.i
    City.where(name: "Indianapolis", state_name: "Indiana").first
  end
  
  scope :nearby, ->(lat, lng, miles) {
     where(
       %{
         ST_DWithin(
           coordinates,
           ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography,
           ?
         )
       },
       lat, lng, miles.to_f * 1609.34 # miles → meters
     ).order(
       Arel.sql(
         "ST_Distance(coordinates, ST_SetSRID(ST_MakePoint(#{lat}, #{lng}), 4326)::geography)"
       )
     )
   }
  
  def near_by(miles)
    # 39.9776° N, 86.0135
    # fails
    #self.class.nearby(lat, lng, miles).where.not(id: id)
    # kinda works
    self.class.nearby(lat, lng, miles).where.not(id: id)
    #self.class.nearby(39.9776, -86.0135, miles).where.not(id: id)
 end
 
 def set_coordinates
    if lat.present? && lng.present?
      self.coordinates = "POINT(#{lng} #{lat})"
    end
  end

end
