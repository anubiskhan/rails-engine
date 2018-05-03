require 'rails_helper'

describe Merchant do
  context 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  context 'business intelligence' do
    it 'returns favorite customer' do
      merchant = create(:merchant)
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
      invoice3 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'failed')
      create(:transaction, invoice_id: invoice3.id, result: 'failed')

      expect(merchant.favorite_customer).to eq(customer1)
    end
  end
end
