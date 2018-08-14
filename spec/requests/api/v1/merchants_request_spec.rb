require 'rails_helper'

describe "Merchants API" do
  before(:each) do
    merchant1 = create(:merchant, id:1, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
    merchant5 = create(:merchant, id:5, name:'hello', created_at:DateTime.new(1234-01-01), updated_at:DateTime.new(1234-01-01))
    merchant2 = create(:merchant, id:2, name:'hello5', created_at:DateTime.new(1234-02-01), updated_at:DateTime.new(1234-02-01))
    merchant3 = create(:merchant, id:3, name:'hello6', created_at:DateTime.new(1234-03-01), updated_at:DateTime.new(1234-03-01))
    merchant4 = create(:merchant, id:4, name:'hello7', created_at:DateTime.new(1234-04-01), updated_at:DateTime.new(1234-07-01))
    merchant6 = create(:merchant, id:6, name:'hello8', created_at:DateTime.new(1234-06-01), updated_at:DateTime.new(1234-07-01))
  end
  context "GET /api/v1/merchants" do
    it "returns a list of merchants" do
      get '/api/v1/merchants'

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first
      expect(merchants.count).to eq(6)
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:name)
      expect(merchant).to_not have_key(:created_at)
      expect(merchant).to_not have_key(:updated_at)
    end
    it 'returns one merchant' do
      get '/api/v1/merchants/1'

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:name)
      expect(merchant[:id]).to eq(1)
      expect(merchant[:name]).to eq('hello')
    end
  end
  context 'GET /api/v1/merchants/find?parameters' do
    it 'should find by the listed parameter' do
      expectedtime = Merchant.find(2).created_at
      expectedtime2 = Merchant.find(4).updated_at
      get '/api/v1/merchants/find?name=hello'

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:name)
      expect(merchant[:id]).to eq(1)
      expect(merchant[:name]).to eq('hello')

      get '/api/v1/merchants/find?id=3'

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:id]).to eq(3)
      expect(merchant[:name]).to eq('hello6')

      get "/api/v1/merchants/find?created_at=#{expectedtime}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:id]).to eq(2)
      expect(merchant[:name]).to eq('hello5')

      get "/api/v1/merchants/find?updated_at=#{expectedtime2}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:id]).to eq(4)
      expect(merchant[:name]).to eq('hello7')
    end
  end
  context 'GET /api/v1/merchants/find_all?parameters' do
    it 'should find all by the listed parameter' do
      expectedtime = Merchant.find(1).created_at
      expectedtime2 = Merchant.find(4).updated_at
      get '/api/v1/merchants/find_all?name=hello'

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.last

      expect(merchants.count).to eq(2)
      expect(merchant).to have_key(:name)
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to eq(5)
      expect(merchant[:name]).to eq('hello')

      get '/api/v1/merchants/find_all?id=3'

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(1)
      expect(merchant[:id]).to eq(3)
      expect(merchant[:name]).to eq('hello6')

      get "/api/v1/merchants/find_all?created_at=#{expectedtime}"

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(2)
      expect(merchant[:id]).to eq(1)
      expect(merchant[:name]).to eq('hello')

      get "/api/v1/merchants/find_all?updated_at=#{expectedtime2}"

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(2)
      expect(merchant[:id]).to eq(4)
      expect(merchant[:name]).to eq('hello7')
    end
  end
  context 'GET /api/v1/merchants/random' do
    it 'should find one random merchant' do
      get '/api/v1/merchants/random'

      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:name)
      expect(merchant).to have_key(:id)
    end
  end
end
