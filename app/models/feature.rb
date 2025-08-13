class Feature < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:fid]
  include FindOrCreate
  
  belongs_to :feature_category
  
  validates_uniqueness_of :fid
  validates_presence_of :fid
  validates_presence_of :feature_category_id
  
end
