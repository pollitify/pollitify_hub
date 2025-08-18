class GoogleSheetUrl < ApplicationRecord
  belongs_to :user
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name]
  include FindOrCreate
  
  def crawl
  end
end
