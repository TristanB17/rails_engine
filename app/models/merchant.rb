class Merchant < ApplicationRecord
  validates_presence_of :id, :name, :created_at, :updated_at
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.find_name(name)
    order(:id).find_by_name(name)
  end
  def self.find_id(id)
    order(:id).find(id)
  end
  def self.find_created_at(created_at)
    order(:id).find_by_created_at(created_at)
  end
  def self.find_updated_at(updated_at)
    order(:id).find_by_updated_at(updated_at)
  end

  def self.find_all_name(name)
    where(name:name)
  end
  def self.find_all_id(id)
    where(id:id)
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

  def self.most_items_by_quantity(quantity)
    joins(:invoices => [:invoice_items, :transactions]).merge(Transaction.success).group(:merchant_id, :id).order("sum(quantity) desc").limit(quantity)
  end

  def self.highest_revenue_date(range)
    select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .joins(:invoices => [:invoice_items, :transactions])
    .merge(Transaction.success)
    .where(invoices: { created_at: range })
    .group("date_trunc('day', invoices.created_at)")
    .order('total_revenue').limit(1).take
  end

  def self.favorite_customer(params)
    select('customers.*, COUNT(invoices.id) AS favorite_customer')
    .joins(invoices: [:transactions, :customer])
    .merge(Transaction.success)
    .group('customers.id')
    .order('favorite_customer DESC')
    .find(params)
  end

  def self.most_revenue(quantity)
    joins(:invoices => [:invoice_items, :transactions]).where(transactions: {result: "success"}).group(:merchant_id, :id).order("sum(quantity * unit_price) desc").limit(quantity)
  end

  def self.revenue_with_date(range, id)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(:invoices => [:invoice_items, :transactions]).where(transactions: {result: "success"}).where(invoices: {created_at: range}).group(:merchant_id, :id).find(id)
  end

  def self.revenue(id)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue').joins(:invoices => [:invoice_items, :transactions]).where(transactions: { result: "success" }).group(:merchant_id, :id).find(id)
  end

  def self.favorite_merchant(id)
    select('merchants.*, count(invoices.id) as invoice_count').joins(:invoices => :transactions).merge(Transaction.success).where(invoices: {customer_id: id}).group(:id).order('invoice_count desc').limit(1).take
  end
end
