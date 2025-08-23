class CongressionalDistrictType < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  def self.federal
    CongressionalDistrictType.where(fid: "federal").first
  end
  
  def self.state
    CongressionalDistrictType.where(fid: "state").first
  end
  
end
