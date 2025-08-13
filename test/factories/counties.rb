FactoryBot.define do
  factory :county do
    name { "MyString" }
    name_ascii { "MyString" }
    name_full { "MyString" }
    county_fips { "MyString" }
    state { nil }
    state_abbreviation { "MyString" }
    state_name { "MyString" }
    lat { "9.99" }
    lng { "9.99" }
    coordinates { "MyString" }
    population { 1 }
  end
end
