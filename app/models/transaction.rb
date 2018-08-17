class Transaction < ApplicationRecord
  validates_presence_of :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at
  belongs_to :invoice

  scope :success, -> {where(result: 'success')}

  def self.find_id(id)
    order(:id).find(id)
  end
  def self.find_invoice_id(invoice_id)
    order(:id).find_by_invoice_id(invoice_id)
  end
  def self.find_credit_card_number(credit_card_number)
    order(:id).find_by_credit_card_number(credit_card_number)
  end
  def self.find_result(result)
    order(:id).find_by_result(result)
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
  def self.find_all_invoice_id(invoice_id)
    order(:id).where(invoice_id:invoice_id)
  end
  def self.find_all_credit_card_number(credit_card_number)
    order(:id).where(credit_card_number:credit_card_number)
  end
  def self.find_all_result(result)
    order(:id).where(result:result)
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
