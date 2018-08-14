FactoryBot.define do
  factory :transaction do
    id (1..100).to_a.sample
    invoice_id (1..100).to_a.sample
    credit_card_number "411"
    credit_card_expiration_date Date.today
    result "total failure"
    created_at DateTime.new(1234-01-01)
    updated_at DateTime.new(1234-01-01)
  end
end
