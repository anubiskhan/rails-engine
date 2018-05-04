class Transaction < ApplicationRecord
  enum result: %w[failed success]

  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }
end
