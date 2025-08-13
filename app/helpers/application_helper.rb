module ApplicationHelper
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
  
  
end
