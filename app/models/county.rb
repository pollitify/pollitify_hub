class County < ApplicationRecord
  belongs_to :state, optional: true
  has_many :cities
  has_many :events
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :state_id]
  include FindOrCreate
end
