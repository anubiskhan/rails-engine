require 'rails_helper'

describe Customer do
  context 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  context 'instance methods' do
    it '#favorite merchant' do
      customer     = create(:customer)
      good_merch   = create(:merchant)
      bad_merch    = create(:merchant)
      good_invoice = create_list(:invoice, 5, customer_id: customer.id, merchant_id: good_merch.id)
      transaction  = create(:transaction, invoice_id: good_invoice.first.id, result: 1)
      bad_invoice  = create(:invoice, customer_id: customer.id, merchant_id: bad_merch.id)
      transaction  = create(:transaction, invoice_id: bad_invoice.id, result: 0)

      expect(customer.favorite_merchant).to eq(good_merch)
    end
  end
end
