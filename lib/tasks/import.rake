require 'csv'

namespace :import do
  desc 'Runs all import tasks'
  task :all do
    Rake::Task['import:merchants'].execute
    Rake::Task['import:customers'].execute
    Rake::Task['import:items'].execute
    Rake::Task['import:invoices'].execute
    Rake::Task['import:transactions'].execute
    Rake::Task['import:invoice_items'].execute
  end

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

  desc 'Imports invoices from CSV'
  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('db/csv/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end

  desc 'Imports items from CSV'
  task items: :environment do
    Item.destroy_all
    CSV.foreach('db/csv/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
  end

  desc 'Imports invoice items from CSV'
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('db/csv/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end
end
