class Role < ApplicationRecord
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name]
  include FindOrCreate
  
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, presence: true, uniqueness: true
    
  def self.super_user
    Role.where(name: 'super_user').first
  end
  
  def self.admin
    Role.where(name: 'admin').first
  end
  
  def self.leadership
    Role.where(name: 'leadership').first
  end
  
  def self.security
    Role.where(name: 'security').first
  end

  def self.volunteer
    Role.where(name: 'volunteer').first
  end

  def self.social_media
    Role.where(name: 'social_media').first
  end
  
end
