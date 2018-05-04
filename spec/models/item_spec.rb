require 'rails_helper'

describe Item do
  context 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
  end
  context 'instance methods' do
<<<<<<< HEAD
    it 'sends top x items by total revenue' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice)
      create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 10)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 4, unit_price: 3)
      create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, quantity: 5, unit_price: 5)
      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')

      expect(Item.most_revenue(2)[0]["id"]).to eq(item3.id)
      expect(Item.most_revenue(2)[1]["id"]).to eq(item1.id)
    end
    it 'sends top x items by total sold' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice)
      create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 10)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, quantity: 4, unit_price: 3)
      create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, quantity: 5, unit_price: 5)
      create(:transaction, invoice_id: invoice1.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')

      expect(Item.most_items(2)[0]["id"]).to eq(item3.id)
      expect(Item.most_items(2)[1]["id"]).to eq(item2.id)
    end
=======
>>>>>>> Add a lot of stuff that fixes most everything.
    it '#best day' do
      item          = create(:item)
      bad_invoice   = create(:invoice, created_at: Date.yesterday)
      good_invoice  = create(:invoice, created_at: Date.tomorrow)
      create_list(:invoice_item, 5, item_id: item.id, invoice_id: good_invoice.id, quantity: 5)
      create_list(:invoice_item, 2, item_id: item.id, invoice_id: bad_invoice.id, quantity: 2)
      create(:transaction, result: 'success', invoice_id: good_invoice.id)

      expect(item.best_day).to eq(good_invoice.created_at)
    end
  end
end
