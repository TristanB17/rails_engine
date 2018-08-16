require 'rails_helper'

describe 'Analytics' do
  before(:each) do
    create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 6, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 7, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-04-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:55 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 3, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:58 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 4, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 5, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-28 14:53:59 UTC")
    create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:2, invoice_id:2, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:3, invoice_id:3, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:4, invoice_id:4, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:5, invoice_id:6, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:6, invoice_id:7, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 1, name:'newitem', description:'anitem', unit_price:9, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 2, name:'spongeboy', description:'anitem', unit_price:8, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 3, name:'beepboop', description:'anitem', unit_price:7, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 4, name:'bapbap', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:9, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:8, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:3, item_id:2, invoice_id:3, quantity:3, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:4, item_id:3, invoice_id:4, quantity:3, unit_price:10, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:5, item_id:4, invoice_id:5, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:6, item_id:1, invoice_id:6, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:7, item_id:1, invoice_id:7, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'GET /api/v1/items/most_revenue?quantity=x' do
    it 'returns top items by variable quantity' do
      get '/api/v1/items/most_revenue?quantity=3'

      items = JSON.parse(response.body, symbolize_names: true)
      item = items.first

      expect(items.count).to eq(3)
      expect(item).to have_key(:description)
      expect(item).to have_key(:name)
      expect(item[:name]).to eq('newitem')
    end
  end
  context 'GET /api/v1/items/:id/best_day' do
    it 'returns date with most sales for a given item' do
      get '/api/v1/items/1/best_day'

      date = JSON.parse(response.body, symbolize_names: true)

      expect(date).to have_key(:best_day)
      expect(date[:best_day]).to eq('2012-03-27T14:53:54.000Z')
    end
  end
end
