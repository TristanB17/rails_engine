require 'rails_helper'

describe InvoiceItem, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:item_id)}
    it {should validate_presence_of(:invoice_id)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  context 'relationships' do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end
end
