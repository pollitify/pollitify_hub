FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    fid { SecureRandom.uuid }
    active { true }
    billing { Faker::Company.industry }
    city { Faker::Address.city }
    organization_website_url { Faker::Internet.url }
    organization_website_domain { Faker::Internet.domain_name }
    sub_domain { Faker::Internet.domain_word }
    polly_domain { Faker::Internet.domain_name }
    polly_url { Faker::Internet.url }
    features { "chat,video,archive" }
    use_pollitify_base_domain { [true, false].sample }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { "password123" }
    password_confirmation { "password123" }

    # Associations
    association :domain
    association :secure_chat_system
    association :state
  end
end


# FactoryBot.define do
#   factory :organization do
#     name { Faker::Company.name }
#     fid { SecureRandom.uuid }
#     active { true }
#     billing { Faker::Company.industry }
#     city { Faker::Address.city }
#     organization_website_url { Faker::Internet.url }
#     organization_website_domain { Faker::Internet.domain_name }
#     sub_domain { Faker::Internet.domain_word }
#     polly_domain { Faker::Internet.domain_name }
#     polly_url { Faker::Internet.url }
#     features { "chat,video,archive" }
#     use_pollitify_base_domain { [true, false].sample }
#     first_name { Faker::Name.first_name }
#     last_name  { Faker::Name.last_name }
#     email { Faker::Internet.email }
#     username { Faker::Internet.username }
#     password { "password123" }
#
#     # Associations
#     association :domain
#     association :secure_chat_system
#     association :state
#   end
# end
#
#
# FactoryBot.define do
#   factory :organization do
#     name { Faker::Company.name }
#     fid { SecureRandom.uuid }
#     active { true }
#     billing { Faker::Company.industry }
#     city { Faker::Address.city }
#     organization_website_url { Faker::Internet.url }
#     organization_website_domain { Faker::Internet.domain_name }
#     sub_domain { Faker::Internet.domain_word }
#     polly_domain { Faker::Internet.domain_name }
#     polly_url { Faker::Internet.url }
#     features { "chat,video,archive" }
#     use_pollitify_base_domain { [true, false].sample }
#     first_name { Faker::Name.first_name }
#     last_name  { Faker::Name.last_name }
#     email { Faker::Internet.email }
#     username { Faker::Internet.username }
#     password { "password123" }
#
#     # Associations
#     association :domain
#     association :secure_chat_system
#     association :state
#   end
# end
