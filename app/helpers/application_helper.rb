module ApplicationHelper
  def post_type_icon(post_type)
    icons = {
      'general' => 'comment',
      'event_attendance' => 'calendar-check',
      'canvassing' => 'door-open',
      'phone_banking' => 'phone',
      'donation' => 'donate',
      'volunteer_work' => 'hands-helping',
      'rally_attendance' => 'bullhorn',
      'voter_registration' => 'vote-yea',
      'petition_gathering' => 'clipboard-list'
    }
    icons[post_type] || 'comment'
  end

  def activism_badge_class(post_type, verified = false)
    if verified
      'bg-success'
    else
      case post_type
      when 'voter_registration', 'canvassing'
        'bg-primary'
      when 'rally_attendance', 'event_attendance'
        'bg-info'
      when 'volunteer_work', 'phone_banking'
        'bg-warning'
      when 'donation'
        'bg-success'
      else
        'bg-secondary'
      end
    end
  end

  def points_color(points)
    case points
    when 15..Float::INFINITY
      'text-success'
    when 8..14
      'text-primary'
    when 1..7
      'text-info'
    else
      'text-muted'
    end
  end
  
  def mobile_device?
     request.user_agent =~ /Mobile|webOS|Android|iPhone|iPad|iPod/
   end
   
   def tab_title(tab_type)
     #raise tab_type.inspect
     case tab_type
     when :event_list
       #raise "In event list"
       return 'Events' if mobile_device?
       return 'Event List'
     when :event_calendar
       return 'Calendar' if mobile_device?
       return 'Event Calendar'
     when :suggest_event
       return 'Suggest' if mobile_device?
       return 'Suggest Event'
     when :search_event
       return 'Search' if mobile_device?
       return 'Search Events'
     when :news
       return 'News'
     end
   end
  
  def render_flash_message(key)
    if flash[key]
      css_class = key.to_s == "notice" ? "success" : "danger"
      content_tag :div, flash[key], class: "alert alert-#{css_class}"
    end
  end
  
  def add_spacer
    "<p>&nbsp;</p>".html_safe
  end
  
  def primary_action_button(text, path, paragraph_break=true)
    # NOTE TESTING NEEDED BEFORE CAN ADD THIS BUT LIKELY SMART TO ADDX
    # if current_user.nil?
    #   flash[:notice] = 'You must be logged in for this action'
    #   redirect_to login_path and return
    # end
    output = []
    output << "<p class='text-center'>"
    output << link_to(text, path, class: 'btn btn-primary')
    output << "</p>" if paragraph_break
    output.join('').html_safe
  end
  
  def report_bug_url(current_url)
    base = "https://github.com/pollitify/pollitify_hub/issues/new"
    title = CGI.escape("Bug report: Issue on #{current_url}")
    body = CGI.escape("## What happened?\n\n[Describe the issue here]\n\n## URL\n#{current_url}")
    "#{base}?title=#{title}&body=#{body}"
  end
  
  def show_event_type(event)
    return event.event_type.name if event.event_type
    return event.event_type_name
  end
  
  def show_event_date(event)
    #raise event.inspect
    return event.date_start_at.strftime("%m-%d") if event.date_start_at
    return event.source_data["Date"]
    #event.date_start.strftime("%m-%d")
  end
  
  
end
