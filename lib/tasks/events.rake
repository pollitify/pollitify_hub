namespace :events do
  #
  # WHAT THE FUCK IS THIS AND IS IT USEFUL
  #
  # webcal://p109-caldav.icloud.com/published/2/NTY4MDE4NDAzNTY4MDE4NO2HPZQpyWT5ScGfZqdCJeF5GD-qD9KCNorqGzJOnFaLjcWo-87UCI4yRVLzjyEW7Ucjk15csElR56iSaFD9TBQ
  #
  
  def write_to_temp_file(filename, content)
    temp_dir = Rails.root.join('tmp')
    file_path = temp_dir.join(filename)

    # Make sure the tmp directory exists
    FileUtils.mkdir_p(temp_dir) unless Dir.exist?(temp_dir)

    File.open(file_path, 'a') do |file|
      file.write(content + "\n")
    end

    file_path.to_s
  end
  
  # be rake events:import_events_from_paste_text
  task :import_events_from_paste_text => :environment do
    filenames = ['suggest01.txt', 'suggest02.txt', 'suggest03.txt', 'suggest04.txt']
    
    filenames.each do |filename|
      text = File.read(File.join(Rails.root, 'lib/tasks/data', filename))
      puts text
      puts EventParser.parse_text(text)
    end
  end
  
  # be rake events:import_google_sheets_from_indiana_resistance_alliance
  task :import_google_sheets_from_indiana_resistance_alliance => :environment do
    require 'csv'
    require "net/http"
    require "uri"
    # get these people to be part of us -- Indianapolis Protest Finder Shelley Ross
    #https://docs.google.com/spreadsheets/d/134J05okcx_bCpTXhofKej2niv-DurfHPBnS8PV02TuQ/edit?gid=0#gid=0
    # source_url = "https://docs.google.com/spreadsheets/d/134J05okcx_bCpTXhofKej2niv-DurfHPBnS8PV02TuQ/edit?gid=0#gid=0"
    # source_url_as_csv = "https://docs.google.com/spreadsheets/d/134J05okcx_bCpTXhofKej2niv-DurfHPBnS8PV02TuQ/export?format=csv&gid=0"
    #
    # uri = URI.parse(source_url)
    # response = Net::HTTP.get(uri)
    #
    # # Convert to UTF-8 safely
    # utf8_data = response.force_encoding("UTF-8")
    #
    # file_path = Rails.root.join('tmp', 'sheet.csv')
    #
    # File.write(file_path, utf8_data)
    
    file_path = Rails.root.join('lib', 'tasks', 'data', 'indiana_resistance_alliance_08_09_25_cleaned.csv')
    #agent = Mechanize.new
    
    Event.destroy_all
    ctr = 0
    CSV.foreach(file_path, headers: true) do |row|
      ctr = ctr + 1
      puts row.to_h
      event_struct = OpenStruct.new()
      event_struct.county_name = row['County']
      event_struct.city_name = row['City']
      state = State.where(name: 'Indiana').first
      event_struct.state_id = state.try(:id)
      if row['Date'] =~ /day/i || row['Date'] =~ /week/i || row['Date'] =~ /month/i || row['Date'] =~ /Starts/i
        write_to_temp_file('weird_dates.txt', row['Date'])
        event_struct.recurrence = row['Date']
        #next
      else
        event_struct.date_start_at = Date.strptime(row['Date'], "%m/%d/%y")        
      end
      #debugger
      if !row['Time (Local)'].blank?
        time_range = EventParser.parse_time_range(row['Time (Local)'], event_struct.date_start_at)
        event_struct.time_start_at = time_range[:start]
        event_struct.time_end_at = time_range[:end]
      end 
      event_struct.name = row['Event Name']
      event_struct.location = row['Location']
      event_struct.organizing_group = row['Group']
      event_struct.event_type_name = row["Type (protest, town hall, ect.)"]
      event_struct.notes = row['Notes/Info']
      if !row['Location'].blank?
        event_struct.address1 = EventParser.extract_address(row['Location'])
      end
      
      if row['Notes/Info'] =~ /http/
        event_struct.url = EventParser.extract_url(row['Notes/Info'])
      end
      
      event_struct.is_suggested_event = true
      
      if event_struct.url =~ /mobilize/
        event_struct.mobilize_url = event_struct.url
      end
      city = City.where(name: row['City'], state_id: state.id).first 
      #debugger
      event_struct.city_id = city.try(:id)
      #county = County.where()
      #debugger
      event_struct.county_id = city.try(:county_id)
      
      #County,City,Date,Time (Local),Event Name,Location,Group,"Type (protest, town hall, ect.)",Notes/Info,
      #debugger
      status, event = Event.find_or_create(event_struct)
      event.update_column(:source_data, row.to_h)
      #debugger
    end
    
    
    #status, event_structs = EventParser.parse_google_sheet_csv(google_sheet_url)
    
  end
end