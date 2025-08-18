FactoryBot.define do
  factory :comment do
    user { nil }
    feed_item { nil }
    body { "MyText" }
  end
end
