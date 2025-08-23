module EventsHelper
#    event.event_type.try(:name) || event.source_data["Notes/Info"] || "Political Protest"

  def event_type(event)
    #
    # Avoid the situation of a notes field is just a link
    #
    return "Political Protest" if event.source_data["Notes/Info"] =~ /http/
    
    #
    # Normal defaults
    #
    return event.event_type.name if event.event_type
    return event.source_data["Notes/Info"] if event.source_data["Notes/Info"]
    return "Political Protest"
  end
  
  def event_time_range(event)
    start_at = event.time_start_at
    end_at   = event.time_end_at

    return "" unless start_at

    if end_at.nil?
      # Only start time, with am/pm + zone
      return start_at.strftime("%-l%P %Z")
    end

    # Same meridian? (both am or both pm)
    if start_at.strftime("%P") == end_at.strftime("%P")
      # Example: 7 - 10pm EDT
      "#{start_at.strftime("%-l")} - #{end_at.strftime("%-l%P")}"
    else
      # Example: 11pm - 1am EDT
      "#{start_at.strftime("%-l%P")} - #{end_at.strftime("%-l%P")}"
    end
  end
end
