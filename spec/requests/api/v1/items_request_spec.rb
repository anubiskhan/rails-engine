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
end
