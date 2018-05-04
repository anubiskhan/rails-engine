class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.most_revenue(quantity = 3)
    unscoped
      .joins(invoices: [:invoice_items, :transactions])
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

  def best_day
    invoices
      .joins(:invoice_items)
      .select('invoices.*, SUM(invoice_items.quantity) AS max')
      .group(:created_at, :id)
      .order('max DESC, created_at DESC')
      .first
      .created_at
  end
end
