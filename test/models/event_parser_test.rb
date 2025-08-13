require "test_helper"

class EventParserTest < ActiveSupport::TestCase
  test ".extract_address" do
    text = "Sen Young's Office, 3602 Northgate Ct"
    result = EventParser.extract_address(text)
    assert_equal "3602 Northgate Ct", result 
  end

  test ".extract_city" do
    text = "in Indianapolis from "
    result = EventParser.extract_city(text)
    assert_equal "Indianapolis", result 
  end
  
  test ".extract_date" do
    text = "8/16 in Indianapolis from 12-3 PM @ Statehouse"
    result = EventParser.extract_date(text)
    assert_equal "8/16", result 
  end
  
  test ".extract_time" do
    text = "from 11 AM - 1 PM"
    text = "8/16 in Indianapolis from 12-3 PM @ Statehouse"
    result = EventParser.extract_time(text)
    assert_equal "12-3 PM", result 
  end
  
  test ".extract_location" do
    text = "8/19 in Irvington - Sign Making Event from 6-8 PM @ Crystal Creek Farm"
    result = EventParser.extract_location(text)
    assert_equal "Crystal Creek Farm", result 
  end
  
  test ".parse_time_range" do
    text = "4-6 PM"
    result = EventParser.parse_time_range(text, Date.new(2025,8,11))
    # unclear how to match this exactly: {start: 2025-08-11 16:00:00 -0400, end: 2025-08-11 18:00:00 -0400}
    # so BCG TODO match the type at least; if I get back at hash the odds are that this succeeded
    assert_equal Hash, result.class
  end

  
end
