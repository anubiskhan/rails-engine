class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants
      .joins(:transactions, :invoices)
      .merge(Transaction.successful)
      .group(:id)
      .order("count(merchants.id) DESC")
      .first
  end
end
