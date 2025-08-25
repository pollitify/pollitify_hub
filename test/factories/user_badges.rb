FactoryBot.define do
  factory :user_badge do
    user { nil }
    badge { nil }
    earned_at { "2025-08-24 10:25:42" }
    points_earned { 1 }
    verification_data { "" }
  end
end
