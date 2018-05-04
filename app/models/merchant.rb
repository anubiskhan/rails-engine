class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customer
    customers
      .joins(:transactions)
      .merge(Transaction.successful)
      .first
  end

  def self.revenue_on_date(date)
    {"total_revenue" => "#{joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 1})
    .where("Date(invoices.created_at) = ?", date)
    .sum("invoice_items.quantity * invoice_items.unit_price")}"}
  end

  def revenue
    invoices
      .joins(:transactions, :invoice_items)
      .where(transactions: {result: 1})
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.most_revenue(quantity = 3)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 1})
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end
end
