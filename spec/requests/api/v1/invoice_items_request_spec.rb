require 'rails_helper'

describe 'Invoice Items API' do
  before(:each) do
    @merchant1 = create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merchant2 = create(:merchant, id: 2, name: 'Rob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @customer1 = create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @customer2 = create(:customer, id: 2, first_name: "Billy", last_name: 'Mays', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice1 = create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice2 = create(:invoice, id: 2, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice3 = create(:invoice, id: 3, merchant_id: 1, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice4 = create(:invoice, id: 4, merchant_id: 2, customer_id: 1, status: 'shipped', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item1 = create(:item, id: 1, name:'newitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item2 = create(:item, id: 2, name:'bitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item3 = create(:item, id: 3, name:'bitem', description:'smitem', unit_price:5.00, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item4 = create(:item, id: 4, name:'Liberty Medical', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:4, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii2 = create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii3 = create(:invoice_item, id:3, item_id:1, invoice_id:3, quantity:1, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii4 = create(:invoice_item, id:4, item_id:2, invoice_id:4, quantity:1, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context "GET /api/v1/invoice_items" do
    it "returns a list of invoice items" do
      get '/api/v1/invoice_items'

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item = invoice_items.first

      expect(invoice_items.count).to eq(4)
      expect(invoice_item).to have_key(:id)
      expect(invoice_item).to have_key(:quantity)
      expect(invoice_item).to have_key(:unit_price)
      expect(invoice_item).to_not have_key(:created_at)
      expect(invoice_item).to_not have_key(:updated_at)
    end
    it 'returns one item' do
      get '/api/v1/invoice_items/1'

      expect(response).to be_successful
      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(invoice_item).to have_key(:id)
      expect(invoice_item).to have_key(:invoice_id)
      expect(invoice_item).to have_key(:item_id)
      expect(invoice_item[:id]).to eq(1)
      expect(invoice_item[:unit_price]).to eq(@ii1.unit_price.to_s)
      expect(invoice_item[:quantity]).to eq(@ii1.quantity)
    end
  end
  context 'returns an invoice_item based on parameters' do
    it 'returns one invoice_item by parameter' do
      get '/api/v1/invoice_items/find?id=2'
      by_id = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_id).to have_key(:id)
      expect(by_id[:id]).to eq(@ii2.id)

      get '/api/v1/invoice_items/find?quantity=3'
      by_quantity = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_quantity).to have_key(:quantity)
      expect(by_quantity[:quantity]).to eq(@ii2.quantity)

      get "/api/v1/invoice_items/find?unit_price=#{@ii3.unit_price}"
      by_price = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_price).to have_key(:unit_price)
      expect(by_price[:unit_price]).to eq(@ii3.unit_price.to_s)
    end
    it 'returns all invoice_items by parameter' do
      get '/api/v1/invoice_items/find_all?id=2'
      invoice_items_id = JSON.parse(response.body, symbolize_names: true)
      by_id = invoice_items_id.first

      expect(response).to be_successful
      expect(by_id).to have_key(:id)
      expect(by_id[:id]).to eq(@ii2.id)

      get '/api/v1/invoice_items/find_all?quantity=1'
      by_quantity = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_quantity.count).to eq(2)
      expect(by_quantity.first[:quantity]).to eq(@ii4.quantity)

      get "/api/v1/invoice_items/find_all?unit_price=#{@ii2.unit_price}"
      by_prices = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_prices.count).to eq(3)
      expect(by_prices.first[:unit_price]).to eq(@ii2.unit_price.to_s)
      expect(by_prices.last[:unit_price]).to eq(@ii2.unit_price.to_s)
    end
  end
  context 'GET /api/v1/items/random' do
    it 'should find one random merchant' do
      get '/api/v1/items/random'

      expect(response).to be_successful
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:name)
      expect(item).to have_key(:id)
    end
  end
end
