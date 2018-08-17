class Customer < ApplicationRecord
  validates_presence_of :id, :first_name, :last_name, :created_at, :updated_at
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  # def self.pending_invoices(params)
  #   where(id: (Invoice.where(id: Transaction.joins(:invoice)
  #                                   .where(result: 'failed').pluck(:invoice_id))
  #                                   .where.not(id: Transaction.joins(:invoice)
  #                                                   .where(result: 'success')
  #                                                   .pluck(:invoice_id))
  #                                                   .where(merchant_id: params)
  #                                                   .pluck(:customer_id)))
  # end

  def self.pending_invoices(merchant_id)
    find_by_sql("SELECT * FROM customers
      INNER JOIN invoices ON customers.id = invoices.customer_id
      INNER JOIN merchants ON invoices.merchant_id = merchants.id
      INNER JOIN transactions ON invoices.id = transactions.id
      WHERE merchants.id = #{merchant_id.to_i}
      EXCEPT
        (SELECT * FROM customers
        INNER JOIN invoices ON customers.id = invoices.customer_id
        INNER JOIN merchants ON invoices.merchant_id = merchants.id
        INNER JOIN transactions ON invoices.id = transactions.invoice_id
        WHERE transactions.result = 'success' AND merchants.id = #{merchant_id.to_i})")
  end
end
