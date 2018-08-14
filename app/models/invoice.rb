class Invoice < ApplicationRecord
  validates_presence_of :id, :merchant_id, :customer_id, :status, :created_at, :updated_at
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
end
