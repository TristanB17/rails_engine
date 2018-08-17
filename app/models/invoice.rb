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

  def self.find_id(id)
    order(:id).find(id)
  end
  def self.find_merchant_id(merchant_id)
    order(:id).find_by_merchant_id(merchant_id)
  end
  def self.find_customer_id(customer_id)
    order(:id).find_by_customer_id(customer_id)
  end
  def self.find_status(status)
    order(:id).find_by_status(status)
  end
  def self.find_created_at(created_at)
    order(:id).find_by_created_at(created_at)
  end
  def self.find_updated_at(updated_at)
    order(:id).find_by_updated_at(updated_at)
  end

  def self.find_all_id(id)
    order(:id).where(id:id)
  end
  def self.find_all_merchant_id(merchant_id)
    order(:id).where(merchant_id:merchant_id)
  end
  def self.find_all_customer_id(customer_id)
    order(:id).where(customer_id:customer_id)
  end
  def self.find_all_status(status)
    order(:id).where(status:status)
  end
  def self.find_all_created_at(created_at)
    order(:id).where(created_at:created_at)
  end
  def self.find_all_updated_at(updated_at)
    order(:id).where(updated_at:updated_at)
  end
  def self.find_random
    all.sample
  end
end
