FactoryBot.define do
  factory :item do
    id (1..100).to_a.sample
    name "Grand Admiral Thrawn's Star Destroyer"
    description "THE VINDICATOR"
    unit_price 4.99
    merchant_id (1..100).to_a.sample
    created_at DateTime.new(1234-01-01)
    updated_at DateTime.new(1234-01-01)
  end
end
