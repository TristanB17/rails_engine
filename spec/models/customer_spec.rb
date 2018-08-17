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
    it {should have_many(:transactions).through(:invoices)}
  end

  context 'class methods' do
    it 'can find by parameters' do
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer2 = create(:customer, id: 2, first_name: 'Tristan', last_name: 'Boy', created_at: "2012-04-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")
      customer3 = create(:customer, id: 3, first_name: 'Colin', last_name: 'Guy', created_at: "2012-05-27 14:53:59 UTC", updated_at: "2012-05-27 14:53:59 UTC")
      customer4 = create(:customer, id: 4, first_name: 'John', last_name: 'Boy', created_at: "2012-06-27 14:53:59 UTC", updated_at: "2012-06-27 14:53:59 UTC")

      expect(Customer.find_id(1)).to eq(customer1)
      expect(Customer.find_first_name('Tristan')).to eq(customer2)
      expect(Customer.find_last_name('Guy')).to eq(customer3)
      expect(Customer.find_created_at("2012-06-27 14:53:59 UTC")).to eq(customer4)
      expect(Customer.find_updated_at("2012-04-27 14:53:59 UTC")).to eq(customer2)
    end
    it 'can find all by parameters' do
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer2 = create(:customer, id: 2, first_name: 'Tristan', last_name: 'Boy', created_at: "2012-04-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")
      customer3 = create(:customer, id: 3, first_name: 'Colin', last_name: 'Guy', created_at: "2012-05-27 14:53:59 UTC", updated_at: "2012-05-27 14:53:59 UTC")
      customer4 = create(:customer, id: 4, first_name: 'John', last_name: 'Boy', created_at: "2012-06-27 14:53:59 UTC", updated_at: "2012-06-27 14:53:59 UTC")

      expect(Customer.find_all_id(1)).to eq([customer1])
      expect(Customer.find_all_first_name('Tristan')).to eq([customer2])
      expect(Customer.find_all_last_name('Guy')).to eq([customer3])
      expect(Customer.find_all_created_at("2012-06-27 14:53:59 UTC")).to eq([customer4])
      expect(Customer.find_all_updated_at("2012-04-27 14:53:59 UTC")).to eq([customer2])
    end
    it 'can find random' do
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer2 = create(:customer, id: 2, first_name: 'Tristan', last_name: 'Boy', created_at: "2012-04-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")
      customer3 = create(:customer, id: 3, first_name: 'Colin', last_name: 'Guy', created_at: "2012-05-27 14:53:59 UTC", updated_at: "2012-05-27 14:53:59 UTC")
      customer4 = create(:customer, id: 4, first_name: 'John', last_name: 'Boy', created_at: "2012-06-27 14:53:59 UTC", updated_at: "2012-06-27 14:53:59 UTC")

      expect(Customer.all).to include(Customer.find_random)
    end
    it 'can find the favorite merchant of any customer' do
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
      invoice3 = create(:invoice, id: 3, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice4 = create(:invoice, id: 4, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
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

      expect(Merchant.favorite_merchant(1)).to eq(merchant2)
    end
  end
end
