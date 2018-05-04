class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity = 3)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 1})
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end
  def self.most_items(quantity = 3)
    select("sum(invoice_items.quantity), items.*")
      .joins(invoices: :transactions)
      .where(transactions: {result: 1})
      .group(:id)
      .order("sum(invoice_items.quantity) DESC")
      .limit(quantity)
  end
end
