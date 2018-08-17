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
    find(id).invoices.select('sum(invoice_items.quantity) as sale_count, invoices.created_at as best_day').joins(:transactions, :invoice_items).merge(Transaction.success).group('invoices.created_at').order('sale_count desc').limit(1).take
  end
end
