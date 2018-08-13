require 'rails_helper'

describe Merchant, type: :model do
  context 'validations' do
    it {should validate_presence_of(:id)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end
end
