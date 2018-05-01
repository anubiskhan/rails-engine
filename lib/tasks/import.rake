require 'csv'

namespace :import do
  desc 'Imports merchants from CSV'
  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('db/csv/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  desc 'Imports transactions from CSV'
  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('db/csv/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end

  desc 'Imports customers from CSV'
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('db/csv/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end
end
