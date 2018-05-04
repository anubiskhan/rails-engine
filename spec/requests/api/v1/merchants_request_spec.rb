require 'rails_helper'

describe 'merchants API' do
  it 'sends all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(5)
  end
  it 'sends one merchant by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(merchant.id)
    expect(json['name']).to eq(merchant.name)
  end
  it 'finds one merchant by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds one merchant by name' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds one merchant by created at' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds one merchant by updated at' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds all merchants by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq(merchant.id)
  end
  it 'finds all merchants by name' do
    merchants = create_list(:merchant, 10, name: 'Same')

    get "/api/v1/merchants/find_all?name=#{merchants.first.name}"

    json = JSON.parse(response.body)

    merchants.each_with_index do |merchant, index|
      expect(json[index]["id"]).to eq(merchant.id)
    end
  end
  it 'sends a random merchant' do
    merchant = create(:merchant)

    get '/api/v1/merchants/random'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'sends merchant invoices' do
    merchant = create(:merchant)
    create_list(:invoice, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.length).to eq(3)
  end
  it 'sends merchant items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.length).to eq(3)
  end
  it 'sends merchant favorite customer' do
    merchant = create(:merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
    invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    create(:transaction, invoice_id: invoice1.id, result: 'success')
    create(:transaction, invoice_id: invoice2.id, result: 'success')
    create(:transaction, invoice_id: invoice2.id, result: 'failed')
    create(:transaction, invoice_id: invoice2.id, result: 'failed')

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(customer1.id)
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

    get "/api/v1/merchants/revenue?date=2018-01-01"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to eq(32)
  end
end
