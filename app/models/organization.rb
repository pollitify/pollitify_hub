class Organization < ApplicationRecord
  belongs_to :secure_chat_system, optional: true
  belongs_to :domain, optional: true
  belongs_to :state#, optional: true
  has_many :users
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :fid
  validates_presence_of :fid
  validates_presence_of :secure_chat_system_id
  validates_presence_of :city
  validates_presence_of :state_id
  validates_presence_of :sub_domain
  validates_presence_of :polly_domain
  validates_presence_of :polly_url
  validates_presence_of :features
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :username
  validates_presence_of :password
  validate :passwords_match
  
  before_create :create_fid_from_name
  
  def create_fid_from_name
    self.fid = name.sub(/ +/,'_').downcase
  end
  
  attr_accessor :password_confirmation
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  attr_accessor :current_step # helper to know where we are in the wizard
  attr_accessor :previous_step # helper to know where we WERE in the wizard
  attr_accessor :next_step # helper to know where we GO NEXT in the wizard
  
  def self.team
    Organization.where(fid: 'team').first
  end
  
  def self.sosindiana
    Organization.where(fid: 'sosindiana').first
  end
  
  #
  # Responsible for copying data from an instance of organization 
  # into a new database along with all supporting tables like states, government_officials, etc
  #
  def populate_instance
    #
    # Make sure that you move over the organization_id from the organization table in the hub -or- organization_fid
    #
  end
  
  private

  def passwords_match
    if password != password_confirmation
      errors.add(:password_confirmation, "does not match password")
    end
  end
  
end
