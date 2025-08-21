require "test_helper"

class BooleanNormalizerTest < ActiveSupport::TestCase
  test "yes should return true" do
    assert_equal true, BooleanNormalizer.normalize("yes")   # => true
  end
  
  test "Y should return true" do
    assert_equal true, BooleanNormalizer.normalize("yes")   # => true
  end
  
  test "mon should return true" do
    assert_equal true, BooleanNormalizer.normalize("mon")   # => true
  end
  
  test "No should return false" do
    assert_equal false, BooleanNormalizer.normalize("No")   # => true
  end
  
  test "no should return false" do
    assert_equal false, BooleanNormalizer.normalize("no")   # => true
  end
  
  test "a blank string should return nil" do
    assert_nil BooleanNormalizer.normalize("")   # => true
  end
  
  test "maybe should return nil" do
    assert_nil BooleanNormalizer.normalize("maybe")   # => true
  end
end
