FactoryBot.define do
  factory :post do
    user { nil }
    content { "MyText" }
    post_type { 1 }
    verified { false }
    points_earned { 1 }
    activity_date { "2025-08-24 07:11:41" }
    location { "MyString" }
  end
end
