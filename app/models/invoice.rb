class Invoice < ApplicationRecord
  enum status: ['pending', 'shipped']

  belongs_to :merchant
  belongs_to :customer
end
