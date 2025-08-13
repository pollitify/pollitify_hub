class State < ApplicationRecord
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :fid]
  include FindOrCreate
  
  has_many :cities
  has_many :events
  
  scope :ordered_by_name, -> { order(:name) }
  
  def self.abbreviation(state_abbreviation)
    self.where(abbreviation: state_abbreviation).first
  end
  
  def self.indiana
    self.where(fid: 'indiana').first
  end
  
  def self.ohio
    self.where(fid: 'ohio').first
  end
  
  def self.illinois
    self.where(fid: 'illinois').first
  end
  
  def generate_url(url_type)
    case url_type
    when :wikipedia_congressional_district_url
      #"https://en.wikipedia.org/wiki/Indiana%27s_congressional_districts"
      return "https://en.wikipedia.org/wiki/#{self.name}%27s_congressional_districts"
    when :wikipedia_congressional_district_map_url
      #
      # BCG TODO -- wrote a scraper for this but know that TEXAS is a fucking problem
      # Or write an In Page javascript function for this
      #
#https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Alabama_Congressional_Districts%2C_119th_Congress.svg/500px-Alabama_Congressional_Districts%2C_119th_Congress.svg.png #https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Maine%27s_congressional_districts_%28since_2023%29.png/960px-Maine%27s_congressional_districts_%28since_2023%29.png
      return nil
    end      
  end
end
