module GovernmentOfficialsHelper
  
  def link_and_phone_call_number(government_official)
    if government_official.nil? || government_official.phone_number.blank?
      return "No Phone Number for this Person" 
    end
    result = "<span class='fs-3'>☎️</span> " + link_to(" #{format_phone_number(government_official.phone_number)}", "tel: #{government_official.phone_number}", class: 'no-underline')
    return result.html_safe
  end
  
  def political_link(go, type)
    #output = []
    case type
    when :ballotopedia
      #https://ballotpedia.org/Andr%C3%A9_Carson
    when :open_secrets
      #https://www.opensecrets.org/members-of-congress/andre-carson/summary?cid=N00029513
    when :website
      str = go.url
      link_to(str, str)
    when :youtube
      str = "https://www.youtube.com/@#{go.youtube}"
      link_to(str, str)
    end
    #return output.join("")
  end
  
end
