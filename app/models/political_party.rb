class PoliticalParty < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  validates :name, presence: true
  validates :fid, presence: true
  
end
