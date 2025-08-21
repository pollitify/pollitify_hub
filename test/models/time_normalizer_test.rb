require "test_helper"

class TimeNormalizerTest < ActiveSupport::TestCase
  
  test  ".has_start_and_end_times? should return true that it has two times for 3:45 - 4:15 PM" do
    assert TimeNormalizer.has_start_and_end_times?("3:45 - 4:15 PM")
  end

  test  ".has_start_and_end_times? should return true that it has two times for 3:45-4:15 PM" do
    assert TimeNormalizer.has_start_and_end_times?("3:45-4:15 PM")
  end

  
  test ".has_start_and_end_times? should return true for 2:00 PM-3:00 PM" do
    assert TimeNormalizer.has_start_and_end_times?("2:00 PM-3:00 PM")
  end
  
  test ".has_start_and_end_times? should return true for 2:00 PM - 3:00 PM" do
    assert TimeNormalizer.has_start_and_end_times?("2:00 PM - 3:00 PM")
  end
  
  
  test ".has_start_and_end_times? should return true for 3:45-4:15 PM" do
    assert TimeNormalizer.has_start_and_end_times?("3:45-4:15 PM")
  end

  test ".has_start_and_end_times? should return true for 3:45 - 4:15 PM" do
    assert TimeNormalizer.has_start_and_end_times?("3:45 - 4:15 PM")
  end

  # test  ".has_start_and_end_times? should return true that it has two times for 2:00 PM-3:00 PM" do
  #   assert TimeNormalizer.has_start_and_end_times?("2:00 PM-3:00 PM")
  # end
  #
  # test  ".has_start_and_end_times? should return true that it has two times for 3:45-4:15 PM" do
  #   assert TimeNormalizer.has_start_and_end_times?("3:45-4:15 PM")
  # end

end
