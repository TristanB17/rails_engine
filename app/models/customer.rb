class Customer < ApplicationRecord
  validates_presence_of :id, :first_name, :last_name, :created_at, :updated_at
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_id(id)
    order(:id).find(id)
  end
  def self.find_first_name(first_name)
    order(:id).find_by_first_name(first_name)
  end
  def self.find_last_name(last_name)
    order(:id).find_by_last_name(last_name)
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
  def self.find_all_first_name(first_name)
    order(:id).where(first_name:first_name)
  end
  def self.find_all_last_name(last_name)
    order(:id).where(last_name:last_name)
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

  def self.pending_invoices(params)
    where(id: (Invoice.where(id: Transaction.joins(:invoice)
                                    .where(result: 'failed').pluck(:invoice_id))
                                    .where.not(id: Transaction.joins(:invoice)
                                                    .where(result: 'success')
                                                    .pluck(:invoice_id))
                                                    .where(merchant_id: params)
                                                    .pluck(:customer_id)))
  end

  # def self.pending_invoices(merchant_id)
  #   find_by_sql("SELECT * FROM customers
  #     INNER JOIN invoices ON customers.id = invoices.customer_id
  #     INNER JOIN merchants ON invoices.merchant_id = merchants.id
  #     INNER JOIN transactions ON invoices.id = transactions.id
  #     WHERE merchants.id = #{merchant_id.to_i}
  #     EXCEPT
  #       (SELECT * FROM customers
  #       INNER JOIN invoices ON customers.id = invoices.customer_id
  #       INNER JOIN merchants ON invoices.merchant_id = merchants.id
  #       INNER JOIN transactions ON invoices.id = transactions.invoice_id
  #       WHERE transactions.result = 'success' AND merchants.id = #{merchant_id.to_i})")
  # end
end
