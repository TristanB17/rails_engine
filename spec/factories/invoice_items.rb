FactoryBot.define do
  factory :invoice_item do
    id (1..100).to_a.sample
    invoice_id (1..100).to_a.sample
    item_id (1..100).to_a.sample
    quantity 7
    unit_price 6.99
    created_at DateTime.new(1234-01-01)
    updated_at DateTime.new(1234-01-01)
  end
end
