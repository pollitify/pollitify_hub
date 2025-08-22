require "test_helper"

class GovernmentOfficialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @government_official = government_officials(:one)
  end

  test "should get index" do
    get government_officials_url
    assert_response :success
  end

  test "should get new" do
    get new_government_official_url
    assert_response :success
  end

  test "should create government_official" do
    assert_difference("GovernmentOfficial.count") do
      post government_officials_url, params: { government_official: { address: @government_official.address, address1: @government_official.address1, address2: @government_official.address2, ballotpedia_id: @government_official.ballotpedia_id, bioguide_id: @government_official.bioguide_id, birthday: @government_official.birthday, bluesky: @government_official.bluesky, bluesky_id: @government_official.bluesky_id, city: @government_official.city, committees: @government_official.committees, congressional_district_id: @government_official.congressional_district_id, contact_form: @government_official.contact_form, cspan_id: @government_official.cspan_id, district: @government_official.district, email_link: @government_official.email_link, facebook: @government_official.facebook, fec_ids: @government_official.fec_ids, first_name: @government_official.first_name, full_address: @government_official.full_address, full_name: @government_official.full_name, gender: @government_official.gender, government_official_type_id: @government_official.government_official_type_id, govtrack_id: @government_official.govtrack_id, icpsr_id: @government_official.icpsr_id, job_type: @government_official.job_type, last_name: @government_official.last_name, lis_id: @government_official.lis_id, mastodon: @government_official.mastodon, middle_name: @government_official.middle_name, nickname: @government_official.nickname, opensecrets_id: @government_official.opensecrets_id, party: @government_official.party, phone: @government_official.phone, phone_number: @government_official.phone_number, political_party_id: @government_official.political_party_id, rss_url: @government_official.rss_url, senate_class: @government_official.senate_class, state_id: @government_official.state_id, state_name: @government_official.state_name, suffix: @government_official.suffix, thomas_id: @government_official.thomas_id, title: @government_official.title, twitter: @government_official.twitter, twitter_id: @government_official.twitter_id, url: @government_official.url, veteran: @government_official.veteran, votesmart_id: @government_official.votesmart_id, washington_post_id: @government_official.washington_post_id, wikipedia_id: @government_official.wikipedia_id, youtube: @government_official.youtube, youtube_id: @government_official.youtube_id, zip: @government_official.zip } }
    end

    assert_redirected_to government_official_url(GovernmentOfficial.last)
  end

  test "should show government_official" do
    get government_official_url(@government_official)
    assert_response :success
  end

  test "should get edit" do
    get edit_government_official_url(@government_official)
    assert_response :success
  end

  test "should update government_official" do
    patch government_official_url(@government_official), params: { government_official: { address: @government_official.address, address1: @government_official.address1, address2: @government_official.address2, ballotpedia_id: @government_official.ballotpedia_id, bioguide_id: @government_official.bioguide_id, birthday: @government_official.birthday, bluesky: @government_official.bluesky, bluesky_id: @government_official.bluesky_id, city: @government_official.city, committees: @government_official.committees, congressional_district_id: @government_official.congressional_district_id, contact_form: @government_official.contact_form, cspan_id: @government_official.cspan_id, district: @government_official.district, email_link: @government_official.email_link, facebook: @government_official.facebook, fec_ids: @government_official.fec_ids, first_name: @government_official.first_name, full_address: @government_official.full_address, full_name: @government_official.full_name, gender: @government_official.gender, government_official_type_id: @government_official.government_official_type_id, govtrack_id: @government_official.govtrack_id, icpsr_id: @government_official.icpsr_id, job_type: @government_official.job_type, last_name: @government_official.last_name, lis_id: @government_official.lis_id, mastodon: @government_official.mastodon, middle_name: @government_official.middle_name, nickname: @government_official.nickname, opensecrets_id: @government_official.opensecrets_id, party: @government_official.party, phone: @government_official.phone, phone_number: @government_official.phone_number, political_party_id: @government_official.political_party_id, rss_url: @government_official.rss_url, senate_class: @government_official.senate_class, state_id: @government_official.state_id, state_name: @government_official.state_name, suffix: @government_official.suffix, thomas_id: @government_official.thomas_id, title: @government_official.title, twitter: @government_official.twitter, twitter_id: @government_official.twitter_id, url: @government_official.url, veteran: @government_official.veteran, votesmart_id: @government_official.votesmart_id, washington_post_id: @government_official.washington_post_id, wikipedia_id: @government_official.wikipedia_id, youtube: @government_official.youtube, youtube_id: @government_official.youtube_id, zip: @government_official.zip } }
    assert_redirected_to government_official_url(@government_official)
  end

  test "should destroy government_official" do
    assert_difference("GovernmentOfficial.count", -1) do
      delete government_official_url(@government_official)
    end

    assert_redirected_to government_officials_url
  end
end
