class Event < ApplicationRecord
  belongs_to :event_type, optional: true
  belongs_to :state
  belongs_to :city, optional: true
  belongs_to :county, optional: true
  belongs_to :organization, optional: true
  belongs_to :congressional_district, optional: true
  
  has_many_attached :files # this can be :images, :attachments, etc.
  
  serialize :source_data, type: Hash, coder: YAML
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :date_start_at, :city_id]
  include FindOrCreate
  
  scope :ordered_by_date, -> { order(date_start_at: :desc) }
  
  
  include MeiliSearch::Rails
  meilisearch do
    # all attributes will be sent to Meilisearch if block is left empty
    displayed_attributes ['id', 'name', 'city', 'state']
    searchable_attributes ['name', 'description', 'city', 'location', 'state']
    #filterable_attributes ['user_id']
    sortable_attributes [:date_start_at, :city]
  end
  
  def event_start_at
    return self.send(:date_start_at) if self.date_start_at
    return Date.today
  end
  
  
end
