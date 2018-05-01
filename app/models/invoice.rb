class Invoice < ApplicationRecord
  enum status: ['pending', 'shipped']

  belongs_to :merchant
end
