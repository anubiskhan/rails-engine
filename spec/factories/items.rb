FactoryBot.define do
  factory :item do
    name { Faker::Food.dish }
    description {Faker::Food.description }
    unit_price { rand(1..1000) }
    merchant
  end
end
