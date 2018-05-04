require 'rails_helper'

describe 'items API' do
  it 'sends all items' do
    create_list(:item, 10)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.length).to eq(10)
  end
  it 'sends an item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(item.id)
  end
  it 'can find an item' do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(item.id)
  end
  it 'can find multiple items' do
    item1 = create(:item, unit_price: 112)
    item2 = create(:item, unit_price: 112)

    get "/api/v1/items/find_all?unit_price=#{item1.unit_price}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]['id']).to eq(item1.id)
    expect(json[1]['id']).to eq(item2.id)
  end
  it 'can find a random item' do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)

    get '/api/v1/items/random'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect([item1.id, item2.id, item3.id]).to include(json['id'])
  end
  it 'sends all associated invoice items' do
    item          = create(:item)
    invoice_items = create_list(:invoice_item, 10, item_id: item.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    json = JSON.parse(response.body)

    expect(response).to be_success
    invoice_items.each_with_index do |invoice_item, index|
      expect(json[index]["id"]).to eq(invoice_item.id)
    end
  end
  it 'sends the associated merchant' do
    merchant = create(:merchant)
    item     = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
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

    get "/api/v1/items/most_revenue?quantity=2"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq(item3.id)
    expect(json[1]["id"]).to eq(item1.id)
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

    get "/api/v1/items/most_items?quantity=2"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq(item3.id)
    expect(json[1]["id"]).to eq(item2.id)
  end
end
