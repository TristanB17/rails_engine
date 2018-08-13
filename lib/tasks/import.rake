require 'csv'

namespace :import_all_csv_data do
  task import_customers: :environment do
    CSV.foreach("./db/csv/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create(id: row[0], first_name: row[1], last_name: row[2], created_at: Date.strptime(row[3]), updated_at: Date.strptime(row[4]))
    end
  end
  task import_merchants: :environment do
    CSV.foreach("./db/csv/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create(id: row[0], name: row[1], created_at: Date.strptime(row[2]), updated_at: Date.strptime(row[3]))
    end
  end
end
