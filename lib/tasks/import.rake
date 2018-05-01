namespace :import do
  desc 'Imports merchants from CSV'
  task merchants: :environment do
    file = 'db/csv/merchants.csv'
  end

  desc 'Imports transactions from CSV'
  task transactions: :environment do
  end

  desc 'Imports customers from CSV'
  task customers: :environment do
  end

end
