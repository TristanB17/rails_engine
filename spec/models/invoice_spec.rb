require 'rails_helper'

describe Invoice, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:merchant_id)}
    it {should validate_presence_of(:customer_id)}
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  context 'relationships' do
    it {should belong_to(:merchant)}
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:transactions)}
  end

  context 'instance methods' do
    it 'can find relationships' do
      merchant1 = create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:1, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:1, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item1 = create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item2 = create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem2 = create(:invoice_item, id:2, item_id:2, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

      expect(invoice1.find_transactions).to eq([transaction1, transaction2, transaction3])
      expect(invoice1.find_invoice_items).to eq([invoiceitem1, invoiceitem2])
      expect(invoice1.find_items).to eq([item1, item2])
      expect(invoice1.find_customer).to eq(customer1)
      expect(invoice1.find_merchant).to eq(merchant1)
    end
  end
end
