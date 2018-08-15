require 'rails_helper'

describe "Merchants API" do
  before(:each) do
    @merchant1 = create(:merchant, id:1, name:'hello', created_at: DateTime.new(1234-01-01), updated_at: DateTime.new(1234-01-01))
    @merchant5 = create(:merchant, id:5, name:'hello', created_at: DateTime.new(1234-01-01), updated_at: DateTime.new(1234-01-01))
    @merchant2 = create(:merchant, id:2, name:'hello5', created_at: DateTime.new(1234-02-01), updated_at: DateTime.new(1234-02-01))
    @merchant3 = create(:merchant, id:3, name:'hello6', created_at: DateTime.new(1234-03-01), updated_at: DateTime.new(1234-03-01))
    @merchant4 = create(:merchant, id:4, name:'hello7', created_at: DateTime.new(1234-04-01), updated_at: DateTime.new(1234-07-01))
    @merchant6 = create(:merchant, id:6, name:'hello8', created_at: DateTime.new(1234-06-01), updated_at: DateTime.new(1234-07-01))
    @customer1 = Customer.create(id: 1, first_name: 'Steve', last_name: 'Campbell', created_at: DateTime.new(1234-06-01), updated_at: DateTime.new(1234-07-01))
    @customer2 = Customer.create(id: 2, first_name: 'Steve', last_name: 'Campbell', created_at: DateTime.new(1234-06-01), updated_at: DateTime.new(1234-07-01))
    @customer3 = Customer.create(id: 3, first_name: 'Steve', last_name: 'Campbell', created_at: DateTime.new(1234-06-01), updated_at: DateTime.new(1234-07-01))
    @item1 = Item.create(id: 1, name: 'Jetpack', description: 'Spider-Man 2 is better than Spider-Man: Homecoming', unit_price: 7, merchant_id: 1, created_at: DateTime.new(1234-06-01), updated_at: DateTime.new(1234-07-01))
    @item2 = Item.create(id: 2, name: 'Knapsack', description: 'Spider-Man 2 is better than Spider-Man: Homecoming', unit_price: 7, merchant_id: 1, created_at: DateTime.new(1234-06-01), updated_at: DateTime.new(1234-07-01))

    create(:invoice, id: 1, merchant: @merchant1, customer: @customer1)
    create(:invoice, id: 2, merchant: @merchant1, customer: @customer2)
    create(:invoice, id: 3, merchant: @merchant1, customer: @customer3)
  end
  context 'invoices' do
    it 'returns all invoices' do

      get "/api/v1/merchants/#{@merchant1.id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body, symbolize_names: true)

      expect(invoices.count).to eq(3)
    end
  end
  context 'customers' do
    it 'returns all relevant customers' do

      get "/api/v1/merchants/#{@merchant1.id}/customers"

      expect(response).to be_successful

      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(3)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer[:first_name]).to eq("Steve")
    end
  end
  context 'items' do
    it 'returns all relevant items' do
      get "/api/v1/merchants/1/items"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      item = items.first

      expect(items.count).to eq(2)
      expect(item).to have_key(:name)
      expect(item).to have_key(:description)
      expect(item[:name]).to eq("Jetpack")
    end
  end
end
