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
    it 'sends revenue of all merchants on a date' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant1.id, created_at: '2018-01-01')
      invoice2 = create(:invoice, merchant_id: merchant2.id, created_at: '2018-01-01')
      create(:invoice_item, invoice_id: invoice1.id, quantity: 2, unit_price: 10)
      create(:invoice_item, invoice_id: invoice2.id, quantity: 4, unit_price: 3)
      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')

      expect(Merchant.revenue_on_date('2018-01-01')).to eq({"total_revenue"=>"32"})
    end
  end
end
