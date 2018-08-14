FactoryBot.define do
  factory :customer do
    id (1..100).to_a.sample
    first_name "Scott"
    last_name "Summers"
    created_at DateTime.new(1234-01-01)
    updated_at DateTime.new(1234-01-01)
  end
end
