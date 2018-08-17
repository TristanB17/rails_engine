class Item < ApplicationRecord
  validates_presence_of :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.best_day(id)
    find(id).invoices
    .select('sum(invoice_items.quantity) as sale_count, invoices.created_at as best_day')
    .joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .group('invoices.created_at')
    .order('sale_count desc').limit(1).take
  end

  def self.most_items(quantity)
    select('items.*, sum(invoice_items.quantity) as number_sold').joins(invoices: [:transactions]).merge(Transaction.success).group(:id).order('number_sold desc').limit(quantity.to_i)
  end

  def self.revenue(quantity)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoices => [:transactions, :invoice_items])
    .where(transactions: { result: "success" })
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end
end
