class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customer
    customers
      .joins(:transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order("count(customers.id) DESC")
      .first
  end

  def self.revenue_on_date(date)
    {"total_revenue" => "#{joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 1})
    .where("Date(invoices.created_at) = ?", date)
    .sum("invoice_items.quantity * invoice_items.unit_price").to_f/100}"}
<<<<<<< HEAD
  end

  def revenue_on_date(date)
    {"revenue" => "#{invoices.joins(:invoice_items, :transactions)
    .where(transactions: {result: 1})
    .where("Date(invoices.created_at) = ?", date)
    .sum("invoice_items.quantity * invoice_items.unit_price").to_f/100}"}
=======
>>>>>>> Add a lot of stuff that fixes most everything.
  end

  def revenue
    {"revenue" => "#{invoices
      .joins(:transactions, :invoice_items)
      .where(transactions: {result: 1})
      .sum("invoice_items.quantity * invoice_items.unit_price").to_f/100}"}
  end

  def revenue_on_date(date)
    {"revenue" => "#{invoices
      .joins(:transactions, :invoice_items)
      .where(transactions: {result: 1})
      .where("Date(invoices.created_at) = ?", date)
      .sum("invoice_items.quantity * invoice_items.unit_price").to_f/100}"}
  end

  def self.most_revenue(quantity = 3)
    joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 1})
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end

  def self.most_items(quantity = 3)
    select("sum(invoice_items.quantity) AS item_num, merchants.*")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: 1})
      .group(:id)
      .order("item_num DESC")
      .limit(quantity)
  end

  def customers_with_pending_invoices
    Customer.find_by_sql([
      "SELECT * FROM merchants m
      JOIN invoices i ON m.id = i.merchant_id
      JOIN transactions t ON i.id = t.invoice_id
      JOIN customers c ON i.customer_id = c.id
      WHERE m.id = 1
      EXCEPT
      SELECT * FROM merchants m
      JOIN invoices i ON m.id = i.merchant_id
      JOIN transactions t ON i.id = t.invoice_id
      JOIN customers c ON i.customer_id = c.id
      WHERE m.id = 1 AND t.result = 1;"
  ])
  end
end
