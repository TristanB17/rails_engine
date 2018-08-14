FactoryBot.define do
  factory :invoice do
    id (1..100).to_a.sample
    merchant_id (1..100).to_a.sample
    customer_id (1..100).to_a.sample
    status "BROADSIDE"
    created_at DateTime.new(1234-01-01)
    updated_at DateTime.new(1234-01-01)
  end
end
