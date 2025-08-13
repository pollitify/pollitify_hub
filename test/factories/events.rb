FactoryBot.define do
  factory :event do
    name { "MyString" }
    event_type { nil }
    event_start_at { "2025-08-08 08:49:48" }
    event_end_at { "2025-08-08 08:49:48" }
    address1 { "MyString" }
    address2 { "MyString" }
    city { "MyString" }
    state { nil }
    organization { nil }
    organization_fid { "MyString" }
    slug { "MyString" }
    fid { "MyString" }
    congressional_district { nil }
    recurring { false }
    recurrence { "MyText" }
    url { "MyString" }
    mobilize_url { "MyString" }
    is_suggested_event { false }
    pasted_description { "MyText" }
  end
end
