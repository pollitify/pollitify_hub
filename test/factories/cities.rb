FactoryBot.define do
  factory :city do
    name { "MyString" }
    fid { "MyString" }
    name_ascii { "MyString" }
    state_fid { "MyString" }
    state_name { "MyString" }
    county_fips { 1 }
    county_name { "MyString" }
    lat { "9.99" }
    lng { "9.99" }
    coordinates { "MyString" }
    population { 1 }
    density { "9.99" }
    source { "MyString" }
    military { false }
    incorporated { false }
    timezone { "MyString" }
    ranking { 1 }
    external_fid { 1 }
    state { nil }
    zips { "MyText" }
  end
end
