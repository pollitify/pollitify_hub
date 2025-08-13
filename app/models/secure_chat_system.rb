class SecureChatSystem < ApplicationRecord
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:fid]
  include FindOrCreate
  
  validates_uniqueness_of :fid
  validates_presence_of :fid
  validates_presence_of :name
  validates_uniqueness_of :name
  
  scope :ordered_by_name, -> { order(:name) }
  
  
  def self.signal
    SecureChatSystem.where(fid: 'signal').first
  end
  
  def self.discord
    SecureChatSystem.where(fid: 'discord').first
  end
  
  def self.mattermost
    SecureChatSystem.where(fid: 'mattermost').first
  end
  
  def self.slack
    SecureChatSystem.where(fid: 'slack').first
  end
  
  def self.other
    SecureChatSystem.where(fid: 'other').first
  end
  
  def self.not_applicable
    SecureChatSystem.where(fid: 'not_applicable').first
  end
end
