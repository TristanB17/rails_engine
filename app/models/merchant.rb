class Merchant < ApplicationRecord
  validates_presence_of :id, :name, :created_at, :updated_at
end
