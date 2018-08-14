require 'rails_helper'

describe 'Invoices API' do
  it 'calling index returns all invoices' do
    Merchant.create!(id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Customer.create!(id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    invoice_1 = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    invoice_2 = Invoice.create!(id: 2, merchant_id: 1, customer_id: 1, status: 'failure', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    invoice_3 = Invoice.create!(id: 3, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    expect(invoices.count).to eq(3)
    expect(invoice).to have_key(:customer_id)
    expect(invoice).to have_key(:merchant_id)
    expect(invoice[:id]).to eq(1)
  end
  it 'view one invoice returns a single invoice' do
    Merchant.create!(id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Customer.create!(id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    invoice_1 = Invoice.create!(id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    ii = invoice_1.id

    get "/api/v1/invoices/#{ii}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice[:id]).to eq(1)
    expect(invoice[:merchant_id]).to eq(1)
    expect(invoice[:customer_id]).to eq(1)
    expect(invoice[:status]).to eq('success')
  end
end
