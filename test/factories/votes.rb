FactoryBot.define do
  factory :vote do
    user { nil }
    news_feed_item { nil }
    value { 1 }
  end
end
