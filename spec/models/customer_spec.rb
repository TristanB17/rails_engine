require 'rails_helper'

describe Customer, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  context 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
  end
end
