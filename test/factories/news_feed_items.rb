FactoryBot.define do
  factory :news_feed_item do
    title { "MyString" }
    url { "MyString" }
    summary { "MyText" }
    published_at { "2025-08-18 04:34:36" }
    guid { "MyString" }
    source { "MyString" }
    news_feed_url { nil }
    image_url { "MyString" }
  end
end
