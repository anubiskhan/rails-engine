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
    it 'sends top x merchants by total revenue' do
      merchant1 = create(:merchant, name: 'M1')
      merchant2 = create(:merchant, name: 'M2')
      merchant3 = create(:merchant, name: 'M3')
      invoice1 = create(:invoice, merchant_id: merchant1.id)
      invoice2 = create(:invoice, merchant_id: merchant2.id)
      invoice3 = create(:invoice, merchant_id: merchant3.id)
      create(:invoice_item, invoice_id: invoice1.id, quantity: 2, unit_price: 10)
      create(:invoice_item, invoice_id: invoice2.id, quantity: 4, unit_price: 3)
      create(:invoice_item, invoice_id: invoice3.id, quantity: 5, unit_price: 5)
      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')

      expect(Merchant.most_revenue(2)[0]["id"]).to eq(merchant3.id)
      expect(Merchant.most_revenue(2)[1]["id"]).to eq(merchant1.id)
    end
    it 'sends customers which have a pending invoice' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer4 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id)
      invoice2 = create(:invoice, customer_id: customer2.id)
      invoice3 = create(:invoice, customer_id: customer3.id)
      invoice4 = create(:invoice, customer_id: customer4.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')
      transaction3 = create(:transaction, invoice_id: invoice3.id, result: 'failed')
      transaction4 = create(:transaction, invoice_id: invoice4.id, result: 'failed')

      expect(pending_customers.length).to eq(2)
    end
  end
  context 'instance methods' do
    it '#revenue' do
      merchant      = create(:merchant)
      invoices      = create_list(:invoice, 2, merchant_id: merchant.id)
      invoice_items = create_list(:invoice_item, 5, invoice_id: invoices.first.id, unit_price: 1100, quantity: 5)
      transaction   = create(:transaction, invoice_id: invoices.first.id, result: 'success')

      expect(merchant.revenue).to eq(27500)
    end
  end
end
