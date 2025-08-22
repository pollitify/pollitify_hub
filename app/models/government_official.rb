class GovernmentOfficial < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :government_official_type
  belongs_to :political_party, optional: true
  belongs_to :congressional_district, optional: true
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:state_name, :full_name, :title]
  include FindOrCreate
  
  # OPEN_STATES = {
  #   ""
  #
  # }
  
  def self.senators
    GovernmentOfficial.where(government_official_type_id: GovernmentOfficialType.senator.id)
  end
  
  def self.representatives
    GovernmentOfficial.where(government_official_type_id: GovernmentOfficialType.congress_person.id)
  end
  #alias_method :representatives, :congress_people
  #alias_method :congress_critters, :congress_people
  
  def self.title(str)
    if str == 'rep'
      return 'Congress Person'
    elsif str == 'sen'
      return 'Senator'
    end
  end
  
  def self.get_title(str)
    if str == 'rep'
      return 'Congress Person'
    elsif str == 'sen'
      return 'Senator'
    end
  end

  def self.get_type(str)
    if str == 'rep'
      return 'congress_person'
    elsif str == 'sen'
      return 'senator'
    end
  end

  
  def color
    return "primary" if self.try(:political_party).try(:name) == "Democrat"
    return "danger" if self.try(:political_party).try(:name) == 'Republican'
    return ''
  end
  
  def senator?
    return true if title == "Senator"
  end
  
  def congress_person?
    return true if title == "Congress Person"
  end
  
  # def committees
  #   GovernmentCommitteeMember.where(government_official_id: self.id).map(&:government_committee).sort_by(&:name)
  # end
  
  def web_url
    if self.email_link
      parts = URI.parse(self.email_link)
      return "https://#{parts.host}"
    end
  end
  
  def possible_congressional_districts
    CongressionalDistrict.where(state_id: self.state_id).order("name")
  end
end
