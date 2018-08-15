require 'rails_helper'

describe 'InvoiceItems API' do
  before(:each) do
    create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'visiting api/v1/invoice_items/:id/invoice' do
    it 'can return the invoice for an invoice_item' do
      get '/api/v1/invoice_items/1/invoice'
      expect(response).to be_successful

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(invoice).to have_key(:id)
      expect(invoice).to have_key(:merchant_id)
      expect(invoice).to have_key(:customer_id)
      expect(invoice).to have_key(:status)
      expect(invoice).to_not have_key(:created_at)
      expect(invoice[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/invoice_items/:id/item' do
    it 'can return the item for an invoice_item' do
      get '/api/v1/invoice_items/1/item'
      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:id)
      expect(item).to have_key(:merchant_id)
      expect(item).to have_key(:name)
      expect(item).to have_key(:description)
      expect(item).to have_key(:unit_price)
      expect(item).to_not have_key(:created_at)
      expect(item[:id]).to eq(1)
    end
  end
end
