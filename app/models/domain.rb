class Domain < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name]
  include FindOrCreate
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  def self.pollitify
    Domain.where(name: 'pollitify.com').first
  end
  
  def self.your_own_domain
    Domain.where(name: 'YOUR_OWN_DOMAIN').first
  end
end
