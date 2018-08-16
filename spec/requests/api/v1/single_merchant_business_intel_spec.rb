require 'rails_helper'

describe 'Analytics' do
  before(:each) do
    create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 2, first_name: 'Stephen', last_name: 'Spielberg', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 3, first_name: 'Stanley', last_name: 'Kubrick', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-04-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 3, merchant_id: 1, customer_id: 2, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 4, merchant_id: 2, customer_id: 2, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date: Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:2, invoice_id:2, credit_card_number:'5658', credit_card_expiration_date: Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:3, invoice_id:3, credit_card_number:'5659', credit_card_expiration_date: Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:4, invoice_id:4, credit_card_number:'5660', credit_card_expiration_date: Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:4, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:3, item_id:1, invoice_id:3, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:4, item_id:2, invoice_id:4, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'visiting /api/v1/merchants/:id/revenue' do
    it 'can return revenue for a single merchant based on successful transactions' do
      get '/api/v1/merchants/1/revenue'

      expect(response).to be_successful
      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue).to have_key(:revenue)
      expect(revenue[:revenue]).to eq('28.0')
    end
  end
  context 'visiting /api/v1/merchants/:id/revenue?date=x' do
    it 'can return revenue for a single merchant based on successful transactions on a specific invoice date' do
      get "/api/v1/merchants/1/revenue?date=2012-04-27"

      expect(response).to be_successful
      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue).to have_key(:revenue)
      expect(revenue[:revenue]).to eq('28.0')
    end
  end
end
