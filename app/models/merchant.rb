class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def favorite_customer
    customers
      .joins(:transactions)
      .merge(Transaction.where(result: 'success'))
      .first
  end
end
