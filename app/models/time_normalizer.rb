class TimeNormalizer
=begin
10 AM - 12 PM
2:00 PM-3:00 PM
11 AM - 10:30 PM
5-8 PM
6:00 PM
11 AM - 1 PM
12-1 PM
4:30-6 PM
Varies
3:45-4:15 PM
=end
  # "2:00 PM-3:00 PM"
  def self.normalize(t_string)    
    t_struct = TimeNormalizer.open_struct
    
    #
    # Handle having two times
    #
    if TimeNormalizer.has_start_and_end_times?(t_string)
    else
      #
      # Handle having only one time
      #
    end
    
  end
  
  def self.has_start_and_end_times?(t_string)
    # It has two times if it has both an AM and PM or two PMs or two AMs
    #2:00 PM-3:00 PM
    return true if t_string =~ /[ap]m[\- 0-9:]+[ap]m/i
    # it has two times if it has two numbers
    return true if t_string =~ /\b(\d{1,2}:\d{2}) *- *(\d{1,2}:\d{2})\s?(AM|PM)\b/i
    # 3:45-4:15 PM
    return true if t_string =~ /\b\d{1,2} *- *\d{1,2}\s?(AM|PM)\b/i
    return false
  end
  
  def self.normalize_start_and_end_times(t_string, t_struct)
    #3:45-4:15 PM
    if t_string =~ /\b(\d{1,2}:\d{2}) *- *(\d{1,2}:\d{2})\s?(AM|PM)\b/i
    #5-8 PM
    elsif t_string =~ /\b\d{1,2} *- *\d{1,2}\s?(AM|PM)\b/i
    #10 AM - 12 PM  
    elsif t_string =~ /\b(\d{1,2})(?::(\d{2}))?\s?(AM|PM)\s*-\s*(\d{1,2})(?::(\d{2}))?\s?(AM|PM)\b/i
    end
    
  end
  
  def self.normalize_start_time(t_string, t_struct)
  end
  
  def self.open_struct
    OpenStruct.new(time_start_at: nil, time_end_at: nil, meridian: nil)
  end
end
