FactoryBot.define do
  factory :invoice do
    customer_id { rand(1..1000) }
    merchant_id { rand(1..1000) }
    status { [0, 1] }
  end
end