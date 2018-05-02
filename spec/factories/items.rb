FactoryBot.define do
  factory :item do
    name { Faker::Food.dish }
    description {Faker::Company.catch_phrase }
    unit_price { rand(1..1000) }
    merchant
  end
end
