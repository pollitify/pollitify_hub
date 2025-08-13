FactoryBot.define do
  factory :secure_chat_system do
    name { Faker::App.name }
    fid { SecureRandom.hex(8) }
    url { Faker::Internet.url }
    icon_url { Faker::Internet.url(path: '/icon.png') }
    description { Faker::Lorem.paragraph }
  end
end