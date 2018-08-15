require 'rails_helper'

describe 'Items API' do
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
    @item2 = create(:item, id: 2, name:'anothernewitem', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item3 = create(:item, id: 3, name:'bitem', description:'smitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item4 = create(:item, id: 4, name:'Liberty Medical', description:'anitem', unit_price:5, merchant_id:1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii1 = create(:invoice_item, id:1, item_id:1, invoice_id:1, quantity:3, unit_price:7, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii2 = create(:invoice_item, id:2, item_id:2, invoice_id:2, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii3 = create(:invoice_item, id:3, item_id:1, invoice_id:3, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @ii4 = create(:invoice_item, id:4, item_id:2, invoice_id:4, quantity:3, unit_price:5, created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context "GET /api/v1/items" do
    it "returns a list of items" do
      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      item = items.first

      expect(items.count).to eq(4)
      expect(item).to have_key(:id)
      expect(item).to have_key(:name)
      # expect(item).to_not have_key(:created_at)
      # expect(item).to_not have_key(:updated_at)
    end
    it 'returns one item' do
      get '/api/v1/items/1'

      expect(response).to be_successful
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:id)
      expect(item).to have_key(:name)
      expect(item[:id]).to eq(1)
      expect(item[:name]).to eq(@item1.name)
    end
  end
  context 'returns an item based on parameters' do
    it 'returns one item by parameter' do
      get '/api/v1/items/find?id=2'
      by_id = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_id).to have_key(:id)
      expect(by_id[:id]).to eq(@item2.id)

      get '/api/v1/items/find?name=Liberty Medical'
      by_name = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(by_name).to have_key(:name)
      expect(by_name[:name]).to eq(@item4.name)
    end
  end
end
