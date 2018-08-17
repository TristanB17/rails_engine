require 'rails_helper'

describe Transaction, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:invoice_id)}
    it {should validate_presence_of(:credit_card_number)}
    it {should validate_presence_of(:credit_card_expiration_date)}
    it {should validate_presence_of(:result)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  context 'relationships' do
    it {should belong_to(:invoice)}
  end

  context 'class methods' do
    it 'can find by parameters' do
      create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:1, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-04-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:1, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-05-27 14:53:59 UTC", updated_at: "2012-05-27 14:53:59 UTC")

      expect(Transaction.find_id(1)).to eq(transaction1)
      expect(Transaction.find_invoice_id(1)).to eq(transaction1)
      expect(Transaction.find_credit_card_number('5658')).to eq(transaction2)
      expect(Transaction.find_result('success')).to eq(transaction3)
      expect(Transaction.find_created_at("2012-04-27 14:53:59 UTC")).to eq(transaction2)
      expect(Transaction.find_updated_at("2012-05-27 14:53:59 UTC")).to eq(transaction3)
    end
    it 'can find all by parameters' do
      create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:1, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-04-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:1, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-05-27 14:53:59 UTC", updated_at: "2012-05-27 14:53:59 UTC")

      expect(Transaction.find_all_id(1)).to eq([transaction1])
      expect(Transaction.find_all_invoice_id(1)).to eq([transaction1, transaction2, transaction3])
      expect(Transaction.find_all_credit_card_number('5658')).to eq([transaction2])
      expect(Transaction.find_all_result('success')).to eq([transaction3])
      expect(Transaction.find_all_created_at("2012-04-27 14:53:59 UTC")).to eq([transaction2])
      expect(Transaction.find_all_updated_at("2012-05-27 14:53:59 UTC")).to eq([transaction3])
    end
    it 'can find random' do
      create(:merchant, id: 1, name: 'Bob', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      create(:customer, id: 1, first_name: 'John', last_name: 'Carpenter', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      create(:invoice, id: 1, merchant_id: 1, customer_id: 1, status: 'success', created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction1 = create(:transaction, id:1, invoice_id:1, credit_card_number:'5656', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      transaction2 = create(:transaction, id:2, invoice_id:1, credit_card_number:'5658', credit_card_expiration_date:Date.today, result:'failure', created_at:"2012-04-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")
      transaction3 = create(:transaction, id:3, invoice_id:1, credit_card_number:'5659', credit_card_expiration_date:Date.today, result:'success', created_at:"2012-05-27 14:53:59 UTC", updated_at: "2012-05-27 14:53:59 UTC")

      expect(Transaction.all).to include(Transaction.find_random)
    end
  end
end
