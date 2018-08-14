require 'rails_helper'

describe 'Invoices API' do
  before(:each) do
    create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:2, invoice_id:1, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:3, invoice_id:1, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice_item, id:2, item_id:2, invoice_id:1, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'visiting api/v1/invoices/:id/transactions' do
    it 'can return all transactions for an invoice' do
      get '/api/v1/invoices/1/transactions'
      expect(response).to be_successful

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:result)
      expect(transaction[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/invoices/:id/invoice_items' do
    it 'can return all invoice_items for an invoice' do
      get '/api/v1/invoices/1/invoice_items'
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item = invoice_items.first

      expect(invoice_items.count).to eq(2)
      expect(invoice_item).to have_key(:item_id)
      expect(invoice_item).to have_key(:quantity)
      expect(invoice_item).to have_key(:unit_price)
      expect(invoice_item[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/invoices/:id/items' do
    it 'can return all items for an invoice' do
      get '/api/v1/invoices/1/items'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      item = items.first

      expect(items.count).to eq(2)
      expect(item).to have_key(:name)
      expect(item).to have_key(:description)
      expect(item).to have_key(:unit_price)
      expect(item).to have_key(:merchant_id)
      expect(item[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/invoices/:id/customer' do
    it 'can return the customer for an invoice' do
      get '/api/v1/invoices/1/customer'
      expect(response).to be_successful

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/invoices/:id/merchant' do
    it 'can return the merchant for an invoice' do
      get '/api/v1/invoices/1/merchant'
      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:name)
      expect(merchant[:id]).to eq(1)
    end
  end
end
