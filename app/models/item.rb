class Item < ApplicationRecord
  validates_presence_of :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
