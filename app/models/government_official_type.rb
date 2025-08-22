class GovernmentOfficialType < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  def self.senator
    self.where(fid: 'senator').first
  end
  
  def self.staff
    self.where(fid: 'staff').first
  end
  
  def self.congress_person
    self.where(fid: 'congress_person').first
  end
end
