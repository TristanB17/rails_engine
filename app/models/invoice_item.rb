class InvoiceItem < ApplicationRecord
  validates_presence_of :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  belongs_to :invoice
  belongs_to :item

  def find_item
    item
  end
  def find_invoice
    invoice
  end

  def self.find_id(id)
    find(id)
  end
  def self.find_invoice_id(invoice_id)
    find_by_invoice_id(id)
  end
  def self.find_item_id(item_id)
    find_by_item_id(item_id)
  end
  def self.find_quantity(quantity)
    find_by_quantity(quantity)
  end
  def self.find_unit_price(unit_price)
    find_by_unit_price(unit_price)
  end
  def self.find_created_at(created_at)
    find_by_created_at(created_at)
  end
  def self.find_updated_at(updated_at)
    find_by_updated_at(updated_at)
  end

  def self.find_all_id(id)
    where(id: id)
  end
  def self.find_all_invoice_id(invoice_id)
    where(invoice_id: invoice_id)
  end
  def self.find_all_item_id(item_id)
    where(item_id: item_id)
  end
  def self.find_all_quantity(quantity)
    where(quantity: quantity)
  end
  def self.find_all_unit_price(unit_price)
    where(unit_price: unit_price)
  end
  def self.find_all_created_at(created_at)
    where(created_at: created_at)
  end
  def self.find_all_updated_at(updated_at)
    where(updated_at: updated_at)
  end

  def self.find_random
    all.sample
  end
end
