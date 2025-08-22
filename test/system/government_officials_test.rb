require "application_system_test_case"

class GovernmentOfficialsTest < ApplicationSystemTestCase
  setup do
    @government_official = government_officials(:one)
  end

  test "visiting the index" do
    visit government_officials_url
    assert_selector "h1", text: "Government officials"
  end

  test "should create government official" do
    visit government_officials_url
    click_on "New government official"

    fill_in "Address", with: @government_official.address
    fill_in "Address1", with: @government_official.address1
    fill_in "Address2", with: @government_official.address2
    fill_in "Ballotpedia", with: @government_official.ballotpedia_id
    fill_in "Bioguide", with: @government_official.bioguide_id
    fill_in "Birthday", with: @government_official.birthday
    fill_in "Bluesky", with: @government_official.bluesky
    fill_in "Bluesky", with: @government_official.bluesky_id
    fill_in "City", with: @government_official.city
    fill_in "Committees", with: @government_official.committees
    fill_in "Congressional district", with: @government_official.congressional_district_id
    fill_in "Contact form", with: @government_official.contact_form
    fill_in "Cspan", with: @government_official.cspan_id
    fill_in "District", with: @government_official.district
    fill_in "Email link", with: @government_official.email_link
    fill_in "Facebook", with: @government_official.facebook
    fill_in "Fec ids", with: @government_official.fec_ids
    fill_in "First name", with: @government_official.first_name
    fill_in "Full address", with: @government_official.full_address
    fill_in "Full name", with: @government_official.full_name
    fill_in "Gender", with: @government_official.gender
    fill_in "Government official type", with: @government_official.government_official_type_id
    fill_in "Govtrack", with: @government_official.govtrack_id
    fill_in "Icpsr", with: @government_official.icpsr_id
    fill_in "Job type", with: @government_official.job_type
    fill_in "Last name", with: @government_official.last_name
    fill_in "Lis", with: @government_official.lis_id
    fill_in "Mastodon", with: @government_official.mastodon
    fill_in "Middle name", with: @government_official.middle_name
    fill_in "Nickname", with: @government_official.nickname
    fill_in "Opensecrets", with: @government_official.opensecrets_id
    fill_in "Party", with: @government_official.party
    fill_in "Phone", with: @government_official.phone
    fill_in "Phone number", with: @government_official.phone_number
    fill_in "Political party", with: @government_official.political_party_id
    fill_in "Rss url", with: @government_official.rss_url
    fill_in "Senate class", with: @government_official.senate_class
    fill_in "State", with: @government_official.state_id
    fill_in "State name", with: @government_official.state_name
    fill_in "Suffix", with: @government_official.suffix
    fill_in "Thomas", with: @government_official.thomas_id
    fill_in "Title", with: @government_official.title
    fill_in "Twitter", with: @government_official.twitter
    fill_in "Twitter", with: @government_official.twitter_id
    fill_in "Url", with: @government_official.url
    check "Veteran" if @government_official.veteran
    fill_in "Votesmart", with: @government_official.votesmart_id
    fill_in "Washington post", with: @government_official.washington_post_id
    fill_in "Wikipedia", with: @government_official.wikipedia_id
    fill_in "Youtube", with: @government_official.youtube
    fill_in "Youtube", with: @government_official.youtube_id
    fill_in "Zip", with: @government_official.zip
    click_on "Create Government official"

    assert_text "Government official was successfully created"
    click_on "Back"
  end

  test "should update Government official" do
    visit government_official_url(@government_official)
    click_on "Edit this government official", match: :first

    fill_in "Address", with: @government_official.address
    fill_in "Address1", with: @government_official.address1
    fill_in "Address2", with: @government_official.address2
    fill_in "Ballotpedia", with: @government_official.ballotpedia_id
    fill_in "Bioguide", with: @government_official.bioguide_id
    fill_in "Birthday", with: @government_official.birthday
    fill_in "Bluesky", with: @government_official.bluesky
    fill_in "Bluesky", with: @government_official.bluesky_id
    fill_in "City", with: @government_official.city
    fill_in "Committees", with: @government_official.committees
    fill_in "Congressional district", with: @government_official.congressional_district_id
    fill_in "Contact form", with: @government_official.contact_form
    fill_in "Cspan", with: @government_official.cspan_id
    fill_in "District", with: @government_official.district
    fill_in "Email link", with: @government_official.email_link
    fill_in "Facebook", with: @government_official.facebook
    fill_in "Fec ids", with: @government_official.fec_ids
    fill_in "First name", with: @government_official.first_name
    fill_in "Full address", with: @government_official.full_address
    fill_in "Full name", with: @government_official.full_name
    fill_in "Gender", with: @government_official.gender
    fill_in "Government official type", with: @government_official.government_official_type_id
    fill_in "Govtrack", with: @government_official.govtrack_id
    fill_in "Icpsr", with: @government_official.icpsr_id
    fill_in "Job type", with: @government_official.job_type
    fill_in "Last name", with: @government_official.last_name
    fill_in "Lis", with: @government_official.lis_id
    fill_in "Mastodon", with: @government_official.mastodon
    fill_in "Middle name", with: @government_official.middle_name
    fill_in "Nickname", with: @government_official.nickname
    fill_in "Opensecrets", with: @government_official.opensecrets_id
    fill_in "Party", with: @government_official.party
    fill_in "Phone", with: @government_official.phone
    fill_in "Phone number", with: @government_official.phone_number
    fill_in "Political party", with: @government_official.political_party_id
    fill_in "Rss url", with: @government_official.rss_url
    fill_in "Senate class", with: @government_official.senate_class
    fill_in "State", with: @government_official.state_id
    fill_in "State name", with: @government_official.state_name
    fill_in "Suffix", with: @government_official.suffix
    fill_in "Thomas", with: @government_official.thomas_id
    fill_in "Title", with: @government_official.title
    fill_in "Twitter", with: @government_official.twitter
    fill_in "Twitter", with: @government_official.twitter_id
    fill_in "Url", with: @government_official.url
    check "Veteran" if @government_official.veteran
    fill_in "Votesmart", with: @government_official.votesmart_id
    fill_in "Washington post", with: @government_official.washington_post_id
    fill_in "Wikipedia", with: @government_official.wikipedia_id
    fill_in "Youtube", with: @government_official.youtube
    fill_in "Youtube", with: @government_official.youtube_id
    fill_in "Zip", with: @government_official.zip
    click_on "Update Government official"

    assert_text "Government official was successfully updated"
    click_on "Back"
  end

  test "should destroy Government official" do
    visit government_official_url(@government_official)
    click_on "Destroy this government official", match: :first

    assert_text "Government official was successfully destroyed"
  end
end
