FactoryBot.define do
  factory :achievement do
    user { nil }
    achievement_type { "MyString" }
    milestone_value { 1 }
    achieved_at { "2025-08-24 10:25:50" }
  end
end
