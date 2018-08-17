require 'rails_helper'

describe Item, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:merchant_id)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  context 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  context 'instance methods' do
    it 'can find relationships' do
      merchant1 = create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item1 = create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item2 = create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice_item1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice_item2 = create(:invoice_item, id:3, item_id:1, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice_item3 = create(:invoice_item, id:2, item_id:2, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

      expect(item1.find_invoice_items).to eq([invoice_item1, invoice_item2])
      expect(item1.find_merchant).to eq(merchant1)
    end
  end

  context 'class methods' do
    it 'can find the best day for an item, and the top items by number sold by variable quantity' do
      merchant1 = create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      merchant2 = create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice6 = create(:invoice, id: 6, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice7 = create(:invoice, id: 7, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-04-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice2 = create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:55 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice3 = create(:invoice, id: 3, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:58 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice4 = create(:invoice, id: 4, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoice5 = create(:invoice, id: 5, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-28 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:2, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:3, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction4 = create(:transaction, id:4, invoice_id:4, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction5 = create(:transaction, id:5, invoice_id:6, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction6 = create(:transaction, id:6, invoice_id:7, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item1 = create(:item, id: 1, name:'newitem', description:'anitem', unit_price:9, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item2 = create(:item, id: 2, name:'spongeboy', description:'anitem', unit_price:8, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item3 = create(:item, id: 3, name:'beepboop', description:'anitem', unit_price:7, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      item4 = create(:item, id: 4, name:'bapbap', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:9, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem2 = create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:8, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem3 = create(:invoice_item, id:3, item_id:2, invoice_id:3, quantity:3, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem4 = create(:invoice_item, id:4, item_id:3, invoice_id:4, quantity:3, unit_price:10, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem5 = create(:invoice_item, id:5, item_id:4, invoice_id:5, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem6 = create(:invoice_item, id:6, item_id:1, invoice_id:6, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      invoiceitem7 = create(:invoice_item, id:7, item_id:1, invoice_id:7, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

      expect(Item.most_items_by_quantity(3)).to eq([item1, item2, item3])
      expect(Item.best_day(1).best_day).to eq('2012-03-27T14:53:54.000Z')
    end
  end
end
