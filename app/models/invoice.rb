class Invoice < ApplicationRecord
  enum status: ['pending', 'shipped']

  belongs_to :merchant
  belongs_to :customer
  has_many   :transactions
  has_many   :invoice_items
  has_many   :items, through: :invoice_items

  scope :success, -> { where(result: 'success') }
end
