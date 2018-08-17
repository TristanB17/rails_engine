class Invoice < ApplicationRecord
  validates_presence_of :id, :merchant_id, :customer_id, :status, :created_at, :updated_at
  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def find_items
    items
  end
  def find_customer
    customer
  end
  def find_merchant
    merchant
  end
  def find_invoice_items
    invoice_items
  end
  def find_transactions
    transactions
  end
end
