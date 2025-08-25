FactoryBot.define do
  factory :badge do
    name { "MyString" }
    description { "MyText" }
    icon { "MyString" }
    color { "MyString" }
    category { "MyString" }
    requirement_type { "MyString" }
    requirement_value { 1 }
    active { false }
  end
end
