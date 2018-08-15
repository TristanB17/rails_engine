require 'rails_helper'

describe 'Transactions API' do
  before(:each) do
    create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:2, invoice_id:1, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    create(:transaction, id:3, invoice_id:1, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end
  context 'visiting api/v1/transactions' do
    it 'shows all transactions' do
      get '/api/v1/transactions'

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)
    end
  end
  context 'visiting api/v1/transactions/1' do
    it 'shows one transaction' do
      get '/api/v1/transactions/1'

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)
    end
  end
  context 'GET /api/v1/transactions/find?parameters' do
    it 'should find by the listed parameter' do
      expectedtime = Transaction.find(1).created_at
      expectedtime2 = Transaction.find(3).updated_at
      get '/api/v1/transactions/find?id=2'

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(2)

      get '/api/v1/transactions/find?invoice_id=1'

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(3)

      get '/api/v1/transactions/find?credit_card_number=5658'

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(2)

      get '/api/v1/transactions/find?result=success'

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(3)

      get "/api/v1/transactions/find?created_at=#{expectedtime}"

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)

      get "/api/v1/transactions/find?updated_at=#{expectedtime2}"

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)
    end
  end
  context 'GET /api/v1/transactions/find_all?parameters' do
    it 'should find all by the listed parameter' do
      expectedtime = Transaction.find(1).created_at
      expectedtime2 = Transaction.find(3).updated_at
      get '/api/v1/transactions/find_all?id=2'

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(1)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(2)

      get '/api/v1/transactions/find_all?invoice_id=1'

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)

      get '/api/v1/transactions/find_all?credit_card_number=5658'

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(1)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(2)

      get '/api/v1/transactions/find_all?result=failure'

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(2)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)

      get "/api/v1/transactions/find_all?created_at=#{expectedtime}"

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)

      get "/api/v1/transactions/find_all?updated_at=#{expectedtime2}"

      expect(response).to be_successful
      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
      expect(transaction[:id]).to eq(1)
    end
  end
  context 'GET /api/v1/transactions/random' do
    it 'should find one random transaction' do
      get '/api/v1/transactions/random'

      expect(response).to be_successful
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(transaction).to have_key(:id)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
      expect(transaction).to_not have_key(:credit_card_expiration_date)
    end
  end
end
