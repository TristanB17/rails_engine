require 'rails_helper'

describe 'Customers API' do
  before(:each) do
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 2, first_name: 'Tristan', last_name: 'Boy', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 3, first_name: 'Colin', last_name: 'Guy', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 4, first_name: 'John', last_name: 'Boy', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'visiting api/v1/customers' do
    it 'shows all customers' do
      get '/api/v1/customers'

      expect(response).to be_successful
      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(4)
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/customers/1' do
    it 'shows one customer' do
      get '/api/v1/customers/1'

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)
    end
  end
  context 'GET /api/v1/customers/find?parameters' do
    it 'should find by the listed parameter' do
      expectedtime = Customer.find(1).created_at
      expectedtime2 = Customer.find(3).updated_at
      get '/api/v1/customers/find?id=2'

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(2)

      get '/api/v1/customers/find?first_name=John'

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)

      get '/api/v1/customers/find?last_name=Carpenter'

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)

      get "/api/v1/customers/find?created_at=#{expectedtime}"

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)

      get "/api/v1/customers/find?updated_at=#{expectedtime2}"

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)
    end
  end
  context 'GET /api/v1/customers/find_all?parameters' do
    it 'should find all by the listed parameter' do
      expectedtime = Customer.find(1).created_at
      expectedtime2 = Customer.find(3).updated_at
      get '/api/v1/customers/find_all?id=2'

      expect(response).to be_successful
      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(1)
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(2)

      get '/api/v1/customers/find_all?first_name=John'

      expect(response).to be_successful
      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(2)
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)

      get '/api/v1/customers/find_all?last_name=Boy'

      expect(response).to be_successful
      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(2)
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(2)

      get "/api/v1/customers/find_all?created_at=#{expectedtime}"

      expect(response).to be_successful
      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(4)
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)

      get "/api/v1/customers/find_all?updated_at=#{expectedtime2}"

      expect(response).to be_successful
      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(4)
      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
      expect(customer[:id]).to eq(1)
    end
  end
  context 'GET /api/v1/customers/random' do
    it 'should find one random customer' do
      get '/api/v1/customers/random'

      expect(response).to be_successful
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(customer).to have_key(:id)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
      expect(customer).to_not have_key(:created_at)
    end
  end
end
