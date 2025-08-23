class Event < ApplicationRecord
  #
  # RELATIONSHIPS
  #  
  belongs_to :event_type, optional: true
  belongs_to :state
  belongs_to :city, optional: true
  belongs_to :county, optional: true
  belongs_to :organization, optional: true
  belongs_to :congressional_district, optional: true
  has_many_attached :files # this can be :images, :attachments, etc.
  
  #
  # VALIDATIONS
  #
  validates :slug, presence: true, uniqueness: true
  
  #
  # SERIALIZERS
  #
  serialize :source_data, type: Hash, coder: YAML
  
  #
  # SCOPES
  #
  scope :ordered_by_date, -> { order(date_start_at: :desc) }

  SLUG_LENGTH = 8
  
  #
  # FIELD MAPPING
  #  
  NAME_FIELD = :name
  ADDRESS1_FIELD = :address1
  ADDRESS2_FIELD = :address2
  CITY_NAME_FIELD = :city_name
  DATE_FIELD = :date_start_at
  TIME_FIELD = :time_start_at
  URL_FIELD = :url
  ZIP_FIELD = :zip

  def self.slug_exists?(slug)
    return 200 if Event.where(slug: slug).first
    return false
  end
  
  # Event.create_slug
  def self.create_slug
    new_slug = SecureRandom.alphanumeric(SLUG_LENGTH)
    status, sc = Event.slug_exists?(new_slug)
    if status == 200
      return Event.create_slug
    end
    new_slug
  end


  #
  # FIND OR CREATE
  #
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name, :date_start_at, :city_id]
  include FindOrCreate

  
  if Rails.env.development? 
    include MeiliSearch::Rails
    meilisearch do
      # all attributes will be sent to Meilisearch if block is left empty
      displayed_attributes ['id', 'name', 'city', 'state']
      searchable_attributes ['name', 'description', 'city', 'location', 'state']
      #filterable_attributes ['user_id']
      sortable_attributes [:date_start_at, :city]
    end
  end
  
  #
  # INSTANCE METHODS
  #
  
  # def event_start_at
  #   return self.send(:date_start_at) if self.date_start_at
  #   return Date.today
  # end
  
  def to_param
    #slug
    #"#{slug} :: #{name}"
    "#{slug}-#{name.parameterize}"
  end
  
  #
  # CLASS METHODS
  #
  
end
