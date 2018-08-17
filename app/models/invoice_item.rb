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
    order(:id).find(id)
  end
  def self.find_invoice_id(invoice_id)
    order(:id).find_by_invoice_id(id)
  end
  def self.find_item_id(item_id)
    order(:id).find_by_item_id(item_id)
  end
  def self.find_quantity(quantity)
    order(:id).find_by_quantity(quantity)
  end
  def self.find_unit_price(unit_price)
    order(:id).find_by_unit_price(unit_price)
  end
  def self.find_created_at(created_at)
    order(:id).find_by_created_at(created_at)
  end
  def self.find_updated_at(updated_at)
    order(:id).find_by_updated_at(updated_at)
  end

  def self.find_all_id(id)
    order(:id).where(id: id)
  end
  def self.find_all_invoice_id(invoice_id)
    order(:id).where(invoice_id: invoice_id)
  end
  def self.find_all_item_id(item_id)
    order(:id).where(item_id: item_id)
  end
  def self.find_all_quantity(quantity)
    order(:id).where(quantity: quantity)
  end
  def self.find_all_unit_price(unit_price)
    order(:id).where(unit_price: unit_price)
  end
  def self.find_all_created_at(created_at)
    order(:id).where(created_at: created_at)
  end
  def self.find_all_updated_at(updated_at)
    order(:id).where(updated_at: updated_at)
  end

  def self.find_random
    all.sample
  end
end
