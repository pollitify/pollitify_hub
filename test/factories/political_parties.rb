FactoryBot.define do
  factory :political_party do
    name { "Example Party" }
    fid { SecureRandom.uuid }
    url { "https://example.com/party" }
  end
end