class Item < ApplicationRecord
  validates_presence_of :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def find_merchant
    merchant
  end
  def find_invoice_items
    invoice_items
  end

  def self.most_items_by_quantity(quantity)
    select('items.*, sum(invoice_items.quantity) as number_sold').joins(invoices: [:transactions]).merge(Transaction.success).group(:id).order('number_sold desc').limit(quantity.to_i)
  end

  def self.best_day(id)
    find(id).invoices
    .select('sum(invoice_items.quantity) as sale_count, invoices.created_at as best_day')
    .joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .group('invoices.created_at')
    .order('sale_count desc').limit(1).take
  end

  def self.revenue(quantity)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoices => [:transactions, :invoice_items])
    .where(transactions: { result: "success" })
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.find_id(id)
    find_by_id(id)
  end
  def self.find_name(name)
    find_by_name(name)
  end
  def self.find_description(description)
    find_by_description(description)
  end
  def self.find_unit_price(unit_price)
    find_by_unit_price(unit_price)
  end
  def self.find_merchant_id(merchant_id)
    find_by_merchant_id(merchant_id)
  end
  def self.find_created_at(created_at)
    find_by_created_at(created_at)
  end
  def self.find_updated_at(updated_at)
    find_by_updated_at(updated_at)
  end

  def self.find_all_id(id)
    where(id:id)
  end
  def self.find_all_name(name)
    where(name:name)
  end
  def self.find_all_description(description)
    where(description:description)
  end
  def self.find_all_unit_price(unit_price)
    where(unit_price:unit_price)
  end
  def self.find_all_merchant_id(merchant_id)
    where(merchant_id:merchant_id)
  end
  def self.find_all_created_at(created_at)
    where(created_at:created_at)
  end
  def self.find_all_updated_at(updated_at)
    where(updated_at:updated_at)
  end

  def self.find_random
    all.sample
  end
end
