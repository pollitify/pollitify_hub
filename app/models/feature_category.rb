class FeatureCategory < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:fid]
  include FindOrCreate
  
  validates_uniqueness_of :fid
  validates_presence_of :fid
  validates_presence_of :name
  
  has_many :features, -> { order(:name) }
  
  # FeatureCategory.security
  def self.security
    FeatureCategory.where(fid: 'security').first
  end
  
  # FeatureCategory.financial
  def self.financial
    FeatureCategory.where(fid: 'financial').first
  end
  
  # FeatureCategory.events
  def self.events
    FeatureCategory.where(fid: 'events').first
  end
  
  # FeatureCategory.office
  def self.office
    FeatureCategory.where(fid: 'office').first    
  end
  
  # FeatureCategory.general
  def self.general
    FeatureCategory.where(fid: 'general').first
  end
    
  # FeatureCategory.get_elected
  def self.get_elected
    FeatureCategory.where(fid: 'get_elected').first    
  end
  
  # FeatureCategory.raise_funds
  def self.raise_funds
    FeatureCategory.where(fid: 'raise_funds').first
  end

  # FeatureCategory.research
  def self.research
    FeatureCategory.where(fid: 'research').first
  end

  # FeatureCategory.group_communications
  def self.group_communications
    FeatureCategory.where(fid: 'group_communications').first
  end


end
