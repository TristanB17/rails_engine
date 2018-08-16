require 'rails_helper'

describe 'Analytics' do
  before(:each) do
    create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:54 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:55 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 3, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:58 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 4, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 5, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-28 14:53:59 UTC")
    create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:2, invoice_id:2, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:3, invoice_id:3, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:4, invoice_id:4, credit_card_number:'5660', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:4, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:3, item_id:1, invoice_id:3, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:4, item_id:2, invoice_id:4, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:5, item_id:2, invoice_id:5, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'visiting /api/v1/merchants/most_revenue?quantity=x' do
    it 'can return top x merchants ranked by total revenue' do
      get '/api/v1/merchants/most_revenue?quantity=1'
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(1)
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to eq('Rob')
    end
  end
  context 'visiting /api/v1/merchants/most_items?quantity=x' do
    it 'can return top x merchants ranked by total number of items sold' do
      get '/api/v1/merchants/most_items?quantity=1'
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(1)
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to eq('Rob')
    end
  end
  context 'visiting /api/v1/merchants/revenue?date=x' do
    it 'returns total revenue for all merchants on a given date' do
      get "/api/v1/merchants/revenue?date=2012-03-27"

      date_revenue = JSON.parse(response.body, symbolize_names: true)

      expect(date_revenue).to have_key(:total_revenue)
      expect(date_revenue[:total_revenue]).to eq("58.0")
    end
  end
end
