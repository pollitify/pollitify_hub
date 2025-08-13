class EventParser
  
  include ActiveModel::Model
  #attr_accessor :name, :email, :message
  
  
  URL_REGEX = /https?:\/\/(?:[-\w.])+(?:\:[0-9]+)?(?:\/(?:[\w\/_.])*(?:\?(?:[\w&=%.])*)?(?:\#(?:[\w.])*)?)?/i
  
  #require "time"
  require 'chronic'
  
  def self.parse_time_range(time_string, date)
    start_time, end_time = time_string.split('-').map(&:strip)
    start_parsed = Chronic.parse("#{date} #{start_time}")
    end_parsed = Chronic.parse("#{date} #{end_time}")
    { start: start_parsed, end: end_parsed }
  end

  # def parse_time_range(str, date: Date.today)
  #   # Match two time expressions, each optional AM/PM
  #   match = str.strip.match(
  #     /\A
  #       (\d{1,2}(?::\d{1,2})?)    # first time (hours[:minutes])
  #       \s*(am|pm)?               # optional AM/PM for first
  #       \s*[-–]\s*                # dash
  #       (\d{1,2}(?::\d{1,2})?)    # second time
  #       \s*(am|pm)?               # optional AM/PM for second
  #     \z/ix
  #   )
  #
  #   raise ArgumentError, "Invalid time range format" unless match
  #
  #   start_time_str, start_meridian, end_time_str, end_meridian = match.captures
  #
  #   # If one meridian is missing, infer it from the other
  #   if start_meridian && !end_meridian
  #     end_meridian = start_meridian
  #   elsif !start_meridian && end_meridian
  #     start_meridian = end_meridian
  #   end
  #
  #   start_str = [start_time_str, start_meridian].compact.join(" ")
  #   end_str   = [end_time_str, end_meridian].compact.join(" ")
  #
  #   start_time = Time.parse("#{date} #{start_str}")
  #   end_time   = Time.parse("#{date} #{end_str}")
  #
  #   # Handle overnight ranges (e.g., 10 PM - 2 AM)
  #   end_time += 86_400 if end_time <= start_time
  #
  #   { start: start_time, end: end_time }
  # end
  
  
  def self.parse_text(text, state=nil)
    result = OpenStruct.new
    result.date = EventParser.extract_date(text)
    result.time = EventParser.extract_time(text)
    result.city = EventParser.extract_city(text)
    result.location = EventParser.extract_location(text)
    result.address = EventParser.extract_address(text)
    result
  end
  
  #County,City,Date,Time (Local),Event Name,Location,Group,"Type (protest, town hall, ect.)",Notes/Info,
# Floyd,New Albany,8/7/25,4-6 PM,"Big, Bad Bill Visibility Protest","Sen Young's Office, 3602 Northgate Ct",Do Something Southern Indiana,Protest,,
# Hamilton,Carmel,8/7/25,6:00 PM,"Unpacking the ""Beautiful"" Bill's Federal Clean Energy Attack & Fighting Back","Carmel Library, Community Room A","Carmel Democratic Club, Indiana Conservation Voters",Meeting,,

  def self.extract_url(text)
    if match = text.match(/(https?:\/\/(?:[-\w.])+(?:\:[0-9]+)?(?:\/(?:[\w\/_.])*(?:\?(?:[\w&=%.])*)?(?:\#(?:[\w.])*)?)?)/i)
      return match[1]
    end
  end
  
  def self.parse_google_sheet_csv(url)
  end
  
  #8/16 in Indianapolis from 12-3 PM @ Statehouse
  #8/16 in Indianapolis from 12-3 PM @ Statehouse
  #8/19 in Irvington - Sign Making Event from 6-8 PM @ Crystal Creek Farm
  #8/23 in Greenwood from 11 AM - 1 PM @ Johnson County Park
  #9/7 in Greenwood from 5:30-7 PM @ Rep. Shreve’s Office (300 S Madison Ave)

  # tested
  def self.extract_date(text)
    if match = text.match(/([1-9][0-9]?\/[0-9]+) /)
      return match[1]
    end
  end
  
  #  in Indianapolis from 
  # tested
  def self.extract_city(text)
    if match = text.match(/in ([A-Z][a-z]+) from/)
      return match[1]
    end
  end
  
  # tested
  def self.extract_location(text)
    if match = text.match(/ @ ([A-Z'’a-z \.]+)/)
      return match[1]
    end
  end
  
  #EventParser.extract_address("Sen Young's Office, 3602 Northgate Ct")
  # tested
  def self.extract_address(text)
    # if match = text.match(/\(([0-9]+ [A-Za-z ]+ \b(?:Ave||Circle|Corner|Avenue|Road|Street|Ct)\b)\)/i)
    #   return match[1]
    # end
    # if match = text.match(/([0-9]+ [A-Za-z ]+ Ave|Circle|Corner|Avenue|Road|Street|Ct)/i)
    #   return match[1]
    # end
    if match = text.match(/\b\d+\s+[\w\s]+?\s(?:Ct|Court|Ave|Avenue|hwy|highway|St|street|Circle)\b/i)
      return match[0]
    end
  end
  
  # tested
  def self.extract_time(text)
    # from 11 AM - 1 PM
    if match = text.match(/([0-9]+ *- *[0-9]+ [AP][M])/)
      return match[1]  # => "9 - 11 AM"
    end
  end
  
  
=begin
Hello Indiana 50501,

I hope this email finds you well. I’m reaching out to personally invite you to a community town hall with Beto O’Rourke in Indianapolis on August 3rd at 3 PM.

Beto O’Rourke is a fourth-generation Texan, born and raised in El Paso, where he has served as a small business owner, a city council representative, and a member of Congress. In 2019 he founded Powered by People, a Texas-based organization that works to expand democracy and produce Democratic victories through voter registration and direct voter engagement.

Beto will be speaking with attendees about state and federal issues. Everyone is welcome to join and we encourage them to sign up!

Link: https://www.mobilize.us/poweredxpeople/event/813561/

If you are unable to attend, we would sincerely appreciate your support in helping to share information about the event with others in the community.

If you have any questions or require additional information, please feel free to reach out to me directly. We would be honored to have you with us and hope to see you there!

Sincerely,
--
Dharini Patel
Events and Logistics Coordinator
dharini@poweredxpeople.org
469-500-3600
=end
  
=begin
  https://www.mobilize.us/poweredxpeople/event/813561/
=end

=begin
  <script type="application/ld+json">[{"@context": "https://schema.org", "@type": "Event", "name": "Indianapolis Town Hall With Beto O'Rourke", "description": "Big news! Beto O\u2019Rourke is coming to Indianapolis, Indiana for a town hall about state and federal issues on Sunday, August 3rd at 3:00 PM EDT.\n\nDoors open at 2:30PM EDT. Event begins promptly at 3:00PM EDT.\n\nIf you need accommodations, please email us at Info@poweredxpeople.org\n\nPlease make sure to register for this event. Everyone is welcome to join!\n\nParking is through Denison Parking using the Park App", "organizer": {"@type": "Organization", "name": "Powered by People", "url": "https://www.mobilize.us/poweredxpeople/"}, "location": {"@type": "Place", "address": {"@type": "PostalAddress", "streetAddress": "1060 N Capitol Ave Suite 1-102", "addressLocality": "Indianapolis", "postalCode": "46204", "addressRegion": "IN", "addressCountry": "US"}, "name": "VisionLoft Stutz"}, "eventAttendanceMode": "https://schema.org/OfflineEventAttendanceMode", "image": ["https://mobilize-uploads-prod.s3.amazonaws.com/uploads/event/Town%20Hall%20Beto_20250418165848264977.jpg"], "startDate": "2025-08-03T19:00:00+00:00", "endDate": "2025-08-03T21:00:00+00:00"}]</script>
=end
  
  # EventParser.parse_from_mobilize_url("https://www.mobilize.us/poweredxpeople/event/813561/")
  def self.parse_from_mobilize_url(url)
    agent = Mechanize.new
    page = agent.get(url)
    
    # Find the script tag with type="application/ld+json"
    json_script = page.search('script[type="application/ld+json"]').first

    if json_script
      # Extract the raw text
      raw_json = json_script.text.strip

      # Parse into Ruby object
      begin
        parsed_json = JSON.parse(raw_json)
        puts parsed_json.inspect
      rescue JSON::ParserError => e
        puts "JSON parsing failed: #{e.message}"
      end
    else
      puts "No ld+json script found"
    end
    
    
    event = OpenStruct.new
    event.title = parsed_json.first['name']
    event.date_start = EventParser.extract_date_from_mobilize_datetime(parsed_json.first['startDate'])
    event.date_end = EventParser.extract_date_from_mobilize_datetime(parsed_json.first['endDate'])
    event.body = parsed_json.first['description']
    event.time_start = EventParser.extract_date_from_mobilize_datetime(parsed_json.first['startDate'])
    event.time_end = EventParser.extract_date_from_mobilize_datetime(parsed_json.first['endDate'])
    #debugger
    event.location = parsed_json.first['location']['address']['streetAddress']
    event.city = parsed_json.first['location']['address']['addressLocality']
    event.state = parsed_json.first['location']['address']['addressRegion']
    
    event
  end
  
  def self.extract_date_from_mobilize_datetime(dt)
    Date.parse(dt)
  end
  
  def self.extract_time_from_mobilize_datetime(dt)
    Time.parse(dt)
  end
  
  def self.parse_title_from_mobilize_page(page)
    page.title
  end
  
  # def self.parse_from_text(text)
  # end
  #
  # def self.extract_phone
  # end
  #
  # def self.extract_email
  # end
  #
  # def self.extract_event_name
  # end
  #
  # def self.extract_event_date
  # end
  #
  # def self.extract_event_time
  # end
  #
  # def self.extract_event_url
  # end
  #
  # def self.extract_event_description
  # end
  
end
