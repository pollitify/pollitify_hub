class GoogleSheetUrl < ApplicationRecord
  belongs_to :user
  
  require 'csv'
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:name]
  include FindOrCreate
  
  def crawl
  end
  
  # GoogleSheetUrl.import_csv_from_the_protest_list
  # https://docs.google.com/spreadsheets/d/1f-30Rsg6N_ONQAulO-yVXTKpZxXchRRB2kD3Zhkpe_A/export?format=csv&id=1f-30Rsg6N_ONQAulO-yVXTKpZxXchRRB2kD3Zhkpe_A
  def self.import_csv_from_the_protest_list(file="the_protest_list.csv")
    header_line = 7
    
    #
    # Partial approach for making it easier in future; not yet used
    # work in progress
    #
    column_mapper = {
      "Date" => Event::DATE_FIELD,
      "Time" => Event::TIME_FIELD,
      "Address" => '',
      "Zip" => Event::ZIP_FIELD,
      "City" => Event::CITY_NAME_FIELD,
      "State" => '',
      "Country" => '',
      "Name" => Event::NAME_FIELD,
      "Link" => Event::URL_FIELD,
      "ADA Accessible" => '',
      "Reoccurring" => ''
    }
    
    file = File.join(Rails.root, 'lib/tasks/data', file)
    
    csv_text = File.readlines(file).drop(7).join
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      # row["HeaderFromLine7"]
      #debugger
      event_struct = OpenStruct.new()
      # Name
      event_struct.name = row["Name"]
      
      # Date and Time
      event_struct.date_start_at = row["Date"]
      event_struct.time_start_at = row["Time"]

      # Location
      event_struct.address1 = row["Address"]
      event_struct.city_name = row["City"]
      event_struct.state_name = row["State"]
      event_struct.zip = row["Zip"]
      
      # Normalized location values
      #debugger
      event_struct.city_id = LocationNormalizer.normalize(:city, row["State"], nil, row["City"]).id
      event_struct.state_id = LocationNormalizer.normalize(:state, row["State"]).id
      
      # Normalized boolean values
      event_struct.ada_accessible = BooleanNormalizer.normalize(row['ADA Accessible'])
      
      # Recurrance
      if row["Reoccurring"].blank?
        event_struct.recurring = false
      else
        event_struct.recurrence = RecurrenceNormalizer.normalize(row['Reoccurring'])
        event_struct.recurring = true if event_struct.recurrence.present?
        debugger
      end
      
      # Source Data
      event_struct.source_data = row.to_h
      #event_struct.date_start_at = 
      
      debugger if Rails.env.development?
    end
  end
end
