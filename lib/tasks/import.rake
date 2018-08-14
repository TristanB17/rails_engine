require 'csv'

namespace :import_csv_data do
  task all: [:import_customers, :import_merchants, :import_items, :import_invoices, :import_invoice_items, :import_transactions]
  task import_customers: :environment do
    CSV.foreach("./db/csv/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create(id: row[0], first_name: row[1], last_name: row[2], created_at: row[3], updated_at:row[4])
    end
  end
  task import_merchants: :environment do
    CSV.foreach("./db/csv/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create(id: row[0], name: row[1], created_at:row[2], updated_at:row[3])
    end
  end
  task import_invoice_items: :environment do
    CSV.foreach("./db/csv/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(id: row[0], item_id:row[1], invoice_id:row[2], quantity:row[3], unit_price:(row[4].to_f)/100, created_at: row[5], updated_at:row[6])
    end
  end
  task import_items: :environment do
    CSV.foreach("./db/csv/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create(id: row[0], name:row[1], description:row[2], unit_price:(row[3].to_f)/100, merchant_id: row[4], created_at: row[5], updated_at:row[6])
    end
  end
  task import_invoices: :environment do
    CSV.foreach("./db/csv/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create(id: row[0], customer_id:row[1], merchant_id:row[2], status:row[3], created_at: row[4], updated_at:row[5])
    end
  end
  task import_transactions: :environment do
    CSV.foreach("./db/csv/transactions.csv", headers: true, header_converters: :symbol) do |row|
      Transaction.create(id: row[0], invoice_id:row[1], credit_card_number:row[2], credit_card_expiration_date:Date.today, result: row[4], created_at: row[5], updated_at:row[6])
    end
  end
end
