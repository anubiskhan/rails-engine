require 'rails_helper'

describe 'invoice items API' do
  it 'sends all invoice items' do
    create_list(:invoice_item, 10)

    get '/api/v1/invoice_items'

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.length).to eq(10)
  end
  it 'sends an invoice item' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice_item.id)
  end
  it 'can find an invoice item' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice_item.id)
  end
  it 'can find multiple invoice items' do
    invoice_item1 = create(:invoice_item, unit_price: 112)
    invoice_item2 = create(:invoice_item, unit_price: 112)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item1.unit_price}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]['id']).to eq(invoice_item1.id)
    expect(json[1]['id']).to eq(invoice_item2.id)
  end
  it 'can find a random invoice item' do
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    invoice_item3 = create(:invoice_item)

    get '/api/v1/invoice_items/random'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect([invoice_item1.id, invoice_item2.id, invoice_item3.id]).to include(json['id'])
  end
end
