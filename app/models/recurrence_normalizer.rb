class RecurrenceNormalizer < ApplicationRecord

=begin
  This class is a Recurrence Normalizer
  
  It is designed to a take a string and normalize it to a struct 
  which can be used to define a recurring event
  
  It takes IN a recurrence string aka r_string
  It puts OUT a recurrence struct aka r_struct
  
  r_struct has two attributes: days and time
  
  days is a mon / tue / wed / thu / fri / sat / sun string 

  # observed values:
  # Mon, Wed
  # Mon, Tue, Thu
  # Yes; 9 am
  # Yes; 10am
  # Yes; 11am
  # 1 pm
  # 1pm
  # 12 pm
  # Sat 7/5 10:00 am
  # Yes; 1pm
  # Yes; 11am
  # Yes; 4pm
  # Yes; 4:30pm

=end
###  

  
  def self.normalize(r_string)
    #
    # Setup
    #
    r_struct = RecurrenceNormalizer.open_struct
    
    return r_struct if r_string.nil?
    
    r_string = RecurrenceNormalizer.strip_junk(r_string)
    
    r_struct = RecurrenceNormalizer.normalize_days(r_string, r_struct)
    r_struct = RecurrenceNormalizer.normalize_time(r_string, r_struct)
    
    return r_struct
  end
  
  def self.open_struct
    r_struct = OpenStruct.new
    r_struct.days = []
    r_struct.time = nil
    
    r_struct
  end
  
  def self.strip_junk(r_string)
    r_string.sub(/Yes; /i,'')
  end
  
  # RecurrenceNormalizer.normalize_time("10:30am", RecurrenceNormalizer.open_struct)
  # RecurrenceNormalizer.normalize_time("10am", RecurrenceNormalizer.open_struct)
  def self.normalize_time(r_string, r_struct)
    # Yes; 10am
    if r_string =~ /^([0-9][0-9]?)([ap]m)/i
      time = $1 + ":00 " + $2
      r_struct.time = time
    elsif  r_string =~ /^([0-9][0-9]?:[0-9][0-9])([ap]m)/i
      time = $1 + " " + $2
      r_struct.time = time
    end
    r_struct
  end
  
  # RecurrenceNormalizer.normalize_days("Mon, Tue, Thu", RecurrenceNormalizer.open_struct)
  def self.normalize_days(r_string, r_struct)
    #
    # Multiple day regex
    #
    regex = /\b(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun)\b/i
    
    #Mon, Tue, Thu
    if r_string =~ /,/
      r_string.scan(regex) do |day|
        r_struct.days << day.downcase
      end
    elsif r_string =~ /[A-Za-z][A-Za-z][A-Za-z]/
      r_string.scan(regex) do |day|
        r_struct.days << day.downcase
      end
    end
    r_struct
  end
end
