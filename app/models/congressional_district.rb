class CongressionalDistrict < ApplicationRecord
  belongs_to :state
  belongs_to :congressional_district_type
  #belongs_to :key_county
  has_many :government_officials
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :state_id, :congressional_district_type_id]
  include FindOrCreate
  
  def full_name
    return self.name
    "#{self.name} -- #{self.key_city} -- #{self.key_county}"
  end
  
end
