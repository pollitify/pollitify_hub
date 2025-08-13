FactoryBot.define do
  factory :state do
    name { "MyString" }
    abbreviation { "MyString" }
    fid { "MyString" }
    population { 1 }
    congressional_district_count { 1 }
    wikipedia_congressional_district_url { "MyString" }
    wikipedia_congressional_district_map_url { "MyString" }
    counties_count { 1 }
    townships_count { "MyString" }
  end
end
