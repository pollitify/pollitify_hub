require "test_helper"

class RecurrenceNormalizerTest < ActiveSupport::TestCase
  
  test ".normalize when given Sat" do
    r_struct = RecurrenceNormalizer.normalize("sat")
    assert_equal r_struct.days, ["sat"]
  end
  
  test ".normalize_time when given 10:30am" do    
    r_struct = RecurrenceNormalizer.normalize("10:30am")
    assert_equal r_struct.time, "10:30 am"
  end
    
  test ".normalize_time when given 9pm" do    
    r_struct = RecurrenceNormalizer.normalize("9pm")
    assert_equal r_struct.time, "9:00 pm"
  end

  test ".normalize_days when given Sat" do
    r_struct = RecurrenceNormalizer.normalize_days("sat", RecurrenceNormalizer.open_struct)
    assert_equal r_struct.days, ["sat"]
  end

  test ".normalize_days when given Sat, Sun" do
    r_struct = RecurrenceNormalizer.normalize_days("Sat, Sun", RecurrenceNormalizer.open_struct)
    assert_equal r_struct.days, ["sat", "sun"]
  end
  


end
