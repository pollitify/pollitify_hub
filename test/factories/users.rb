FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    first_name { "John" }
    last_name { "Doe" }
    date_of_birth { 25.years.ago.to_date }
    role { "user" }

    password { "password123" }
    password_confirmation { "password123" }

    confirmed_at { Time.current } # Simulates a confirmed account

    # Optional: traits for different roles or states
    trait :admin do
      role { "admin" }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :locked do
      locked_at { Time.current }
    end
  end
end