class Merchant < ApplicationRecord
  validates_presence_of :id, :name, :created_at, :updated_at
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
end
