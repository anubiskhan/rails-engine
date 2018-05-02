class Transaction < ApplicationRecord
  enum result: %w[failed success]

  belongs_to :invoice
end
