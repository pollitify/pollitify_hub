module ContactCardsHelper
  
  def output_farley_file(contact_card)
    output = []

    ContactCard::FARLEY_FIELDS.each do |field| 
      #show_contact_field(contact_card, field)
      field_of_data = contact_card.send(field)
      next if field_of_data.blank?
      #raise "foo"
      if field_of_data.to_s =~ /\n/
        #output << simple_format(str_data)
        output << simple_format("<p><strong>#{field.to_s.humanize}</strong>: #{field_of_data}</p>")
      else
        output << "<p><strong>#{field.to_s.humanize}</strong>: #{field_of_data}</p>"
      end
      hit_something = true
      #output << "<p><strong>#{field.to_s.humanize}</strong>: #{field_of_data}</p>"
    end
    #raise output.inspect
    return if output.empty?
    output.join('').html_safe 
    
  end
  
  def output_history_and_notes(contact_card)
    output = []
    hit_something = false
    ContactCard::HISTORY_AND_NOTES_FIELDS.each do |field|
      #show_contact_field(contact_card, field)
      field_of_data = contact_card.send(field)
      next if field_of_data.blank?
      
      hit_something = true
      output << "<p><strong>#{field.to_s.humanize}</strong>: #{simple_format(field_of_data)}</p>"
    end
    ##raise output.inspect
    return if output.empty?
    output.join('').html_safe 
  end
  
  def output_links(contact_card)
    output = []
    hit_something = false
    ContactCard::ONLINE_FIELDS.each do |field|
      #show_contact_field(contact_card, field)
      field_of_data = contact_card.send(field)
      next if field_of_data.blank?
      
      hit_something = true
      output << "<p><strong>#{field.to_s.humanize}</strong>: #{link_to(field_of_data, field_of_data)}</p>"
    end
    ##raise output.inspect
    return if output.empty?
    output.join('').html_safe 
  end
  
  def output_skills(contact_card)
    output = []
    hit_something = false
    ContactCard::SKILL_FIELDS.each do |field|
      #show_contact_field(contact_card, field)
      field_of_data = contact_card.send(field)
      next if field_of_data.blank?
      
      hit_something = true
      output << "<p><strong>#{field.to_s.humanize}</strong>: #{field_of_data}</p>"
    end
    ##raise output.inspect
    return if output.empty?
    output.join('').html_safe 
  end
  
  def output_importance(contact_card)
    output = []
    hit_something = false
    ContactCard::IMPORTANCE_FIELDS.each do |field|
      #show_contact_field(contact_card, field)
      field_of_data = contact_card.send(field)
      next if field_of_data.blank?
      
      hit_something = true
      output << "<p><strong>#{field.to_s.humanize}</strong>: #{show_yes_no(field)}</p>"
    end
    output.join('').html_safe
  end
  
  def output_address(contact_card)
    output = []
    hit_something = false
    ContactCard::ADDRESS_FIELDS.each do |field|
      #show_contact_field(contact_card, field)
      field_of_data = contact_card.send(field)
      
      if field_of_data.is_a?(CongressionalDistrict)
        field_of_data = field_of_data.full_name
      elsif field_of_data.is_a?(Organization)
        field_of_data = field_of_data.name
      end
      
      #raise field_of_data.inspect
      
      next if field_of_data.blank?
      
      hit_something = true
      output << "<p><strong>#{field.to_s.humanize}</strong>: #{field_of_data}</p>"
    end
    output.join('').html_safe
  end
  
  def show_contact_field(contact_card, field)
    output = []
    field_of_data = contact_card.send(field)
    return if field_of_data.blank?
    
    output << "<p><strong>#{field.to_s.humanize}</strong>:</p>"
    output << "<p>"
    str_data = contact_card.send(field)
    output << simple_format(str_data)
    output << "</p>"
    output.join('').html_safe
  end
  
  def contact_them_link(contact_card, tuple)
    #
    # Unpack tuple into vars for clarity
    #
    field = tuple.first
    method = tuple.second
    prompt = tuple.third
    
    #
    # No data check
    #
    output = []
    field_of_data = contact_card.send(field)
    return if field_of_data.blank?
    
    output << "<p><strong>#{prompt}</strong>: #{send(method, contact_card)}</p>"
    # output << "<p>"
    # str_data = contact_card.send(field)
    # output << simple_format(str_data)
    # output << "</p>"
    output.join('').html_safe
  end
  
  def format_phone_number(phone)
    cleaned = phone.to_s.gsub(/\D/, '')
    #raise cleaned.inspect
    if cleaned.length == 10
      "(#{cleaned[0..2]}) #{cleaned[3..5]}-#{cleaned[6..9]}"
    else
      phone
    end
  end
  
  def link_and_url(contact_card)
    if contact_card.url.blank? 
      return "N/A" 
    end
    link_to('🔗', "#{contact_card.url}", class: 'no-underline').html_safe
  end
  
  def link_and_email(contact_card)
    if contact_card.email_primary.blank? 
      return "No primary email for this person" 
    end
    return "<span class='fs-3'>📧</span> " + link_to("#{contact_card.email_primary}", "mail_to: #{contact_card.email_primary}", class: 'no-underline')
  end
  
  def link_and_phone_call(contact_card)
    if contact_card.nil? || contact_card.phone_mobile.blank?
      return "No Mobile Phone Number for this Person" 
    end
    return "<span class='fs-3'>☎️</span> " + link_to(" #{format_phone_number(contact_card.phone_mobile)}", "tel: #{contact_card.phone_mobile}", class: 'no-underline')
  end
  
  def link_and_text_message(contact_card)
    if contact_card.nil? || contact_card.phone_mobile.blank?
      return "No Mobile Phone Number for this Person" if contact_card.nil? 
    end
    return "<span class='fs-3'>📲</span> " +  link_to(" #{format_phone_number(contact_card.phone_mobile)}", "sms: #{contact_card.phone_mobile}", class: 'no-underline')
  end
  
  def link_and_signal_message(contact_card)
    if contact_card.nil? || contact_card.signal_me_url.blank?
      return "No Signal Me Url for this Person" 
    end
    return "<span class='fs-3'>💬</span> " +  link_to("Signal #{contact_card.first_name}", contact_card.signal_me_url, class: 'no-underline')    
  end
end
