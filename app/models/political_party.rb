class PoliticalParty < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  validates :name, presence: true
  validates :fid, presence: true
  
  def self.make_fid_from_name(name)
    name.downcase.gsub(/ +/,'_')
  end
  
  def self.republican
    PoliticalParty.where(fid: 'republican').first
  end
  
  def self.democrat
    PoliticalParty.where(fid: 'democrat').first
  end
  
  def self.democratic
    PoliticalParty.where(fid: 'democrat').first
  end
  
end
