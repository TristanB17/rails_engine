FactoryBot.define do
  factory :merchant do
    id (1..100).to_a.sample
    name "Grand Admiral Thrawn"
    created_at DateTime.new(1234-01-01)
    updated_at DateTime.new(1234-01-01)
  end
end
