FactoryBot.define do
  factory :feature do
    name { Faker::App.name }
    fid { SecureRandom.uuid }
    association :feature_category
    description { Faker::Lorem.paragraph }
    status { %w[active inactive deprecated].sample }
    active { true }
  end
end