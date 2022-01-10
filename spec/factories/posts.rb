FactoryBot.define do
  factory :post do
    date { "2022-01-10" }
    prefecture { "MyString" }
    municipality { "MyString" }
    content { "MyText" }
    number { 1 }
    user { nil }
  end
end
