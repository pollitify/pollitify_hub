class BooleanNormalizer
  TRUE_VALUES  = %w[true t yes y 1 	mon tue wed thu thurs fri sat sun].freeze
  FALSE_VALUES = %w[false f no n 0].freeze

  def self.normalize(value)
    return nil if value.nil? || value.to_s.strip.empty?

    str = value.to_s.strip.downcase
    if TRUE_VALUES.include?(str)
      true
    elsif FALSE_VALUES.include?(str)
      false
    else
      nil # unknown value, treat as nil or raise error depending on your needs
    end
  end
end