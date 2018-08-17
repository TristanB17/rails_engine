require 'rails_helper'

describe Merchant, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  context 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  context 'class methods' do
    it 'can find by parameters' do
      merchant1 = create(:merchant, id:1, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
      merchant5 = create(:merchant, id:5, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
      merchant2 = create(:merchant, id:2, name:'hello5', created_at:DateTime.new(1234-02-01), updated_at:DateTime.new(1234-02-01))
      merchant3 = create(:merchant, id:3, name:'hello6', created_at:DateTime.new(1234-03-01), updated_at:DateTime.new(1234-03-01))
      merchant4 = create(:merchant, id:4, name:'hello7', created_at:DateTime.new(1234-04-01), updated_at:DateTime.new(1234-07-01))
      merchant6 = create(:merchant, id:6, name:'hello8', created_at:DateTime.new(1234-06-01), updated_at:DateTime.new(1234-07-01))

      expect(Merchant.find_name('hello')).to eq(merchant1)
      expect(Merchant.find_id('3')).to eq(merchant3)
      expect(Merchant.find_created_at(merchant2.created_at)).to eq(merchant2)
      expect(Merchant.find_updated_at(merchant3.updated_at)).to eq(merchant3)
    end
    it 'can find all by parameters' do
      merchant1 = create(:merchant, id:1, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
      merchant5 = create(:merchant, id:5, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
      merchant2 = create(:merchant, id:2, name:'hello5', created_at:DateTime.new(1234-02-01), updated_at:DateTime.new(1234-02-01))
      merchant3 = create(:merchant, id:3, name:'hello6', created_at:DateTime.new(1234-03-01), updated_at:DateTime.new(1234-03-01))
      merchant4 = create(:merchant, id:4, name:'hello7', created_at:DateTime.new(1234-04-01), updated_at:DateTime.new(1234-07-01))
      merchant6 = create(:merchant, id:6, name:'hello8', created_at:DateTime.new(1234-06-01), updated_at:DateTime.new(1234-07-01))

      expect(Merchant.find_all_name('hello')).to eq([merchant1, merchant5])
      expect(Merchant.find_all_id('3')).to eq([merchant3])
      expect(Merchant.find_all_created_at(merchant1.created_at)).to eq([merchant1, merchant5])
      expect(Merchant.find_all_updated_at(merchant4.updated_at)).to eq([merchant4, merchant6])
    end
    it 'can find a random merchant' do
      merchant1 = create(:merchant, id:1, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
      merchant5 = create(:merchant, id:5, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
      merchant2 = create(:merchant, id:2, name:'hello5', created_at:DateTime.new(1234-02-01), updated_at:DateTime.new(1234-02-01))
      merchant3 = create(:merchant, id:3, name:'hello6', created_at:DateTime.new(1234-03-01), updated_at:DateTime.new(1234-03-01))
      merchant4 = create(:merchant, id:4, name:'hello7', created_at:DateTime.new(1234-04-01), updated_at:DateTime.new(1234-07-01))
      merchant6 = create(:merchant, id:6, name:'hello8', created_at:DateTime.new(1234-06-01), updated_at:DateTime.new(1234-07-01))

      expect(Merchant.all).to include(Merchant.find_random)
    end
    it 'can find the top x merchants by total number of items sold' do
      merchant1 = create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant2 = create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice2 = create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:55 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice3 = create(:invoice, id: 3, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:58 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice4 = create(:invoice, id: 4, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice5 = create(:invoice, id: 5, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-28 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:2, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:3, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction4 = create(:transaction, id:4, invoice_id:4, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item1 = create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item2 = create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:4, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem2 = create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem3 = create(:invoice_item, id:3, item_id:1, invoice_id:3, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem4 = create(:invoice_item, id:4, item_id:2, invoice_id:4, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem5 = create(:invoice_item, id:5, item_id:2, invoice_id:5, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

      expect(Merchant.most_items_by_quantity(1)).to eq([merchant2])
    end
  end
  context 'instance methods' do
    it 'can find total revenue for a merchant, total or by date' do
      merchant1 = create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant2 = create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer2 = create(:customer, id: 2, first_name: 'Stephen', last_name: 'Spielberg', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer3 = create(:customer, id: 3, first_name: 'Stanley', last_name: 'Kubrick', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-04-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice2 = create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice3 = create(:invoice, id: 3, merchant_id: 1, customer_id: 2, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice4 = create(:invoice, id: 4, merchant_id: 2, customer_id: 2, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date: Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:2, credit_card_number:'5658', credit_card_expiration_date: Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:3, credit_card_number:'5659', credit_card_expiration_date: Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction4 = create(:transaction, id:4, invoice_id:4, credit_card_number:'5660', credit_card_expiration_date: Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item1 = create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item2 = create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:4, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem2 = create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem3 = create(:invoice_item, id:3, item_id:1, invoice_id:3, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem4 = create(:invoice_item, id:4, item_id:2, invoice_id:4, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

      expect(Merchant.find_revenue(1).revenue).to eq(28.0)
      expect(Merchant.find_revenue_date(1,'2012-04-27').revenue).to eq(28.0)
    end
  end
end
