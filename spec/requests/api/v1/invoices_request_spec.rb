require 'rails_helper'

describe 'invoices API' do
  it 'sends all invoices' do
    create_list(:invoice, 10)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.length).to eq(10)
  end
  it 'send an invoice' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['customer_id']).to eq(invoice.customer_id)
    expect(json['merchant_id']).to eq(invoice.merchant_id)
  end
  it 'can find an invoice by id' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/find?id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by customer id' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by merchant id' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by status' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/find?status=#{invoice.status}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by created at' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by updated at' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find all invoices by merchant id' do
    merchant = create(:merchant)
    invoice1 = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')
    invoice2 = Invoice.create!(customer_id: 18, merchant_id: merchant.id, status: 'shipped')

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]['id']).to eq(invoice1.id)
    expect(json[1]['id']).to eq(invoice2.id)
  end
  it 'can find all invoices by a different parameter' do
    merchant = create(:merchant)
    invoice1 = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')
    Invoice.create!(customer_id: 18, merchant_id: merchant.id, status: 'shipped')
    invoice3 = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'shipped')

    get '/api/v1/invoices/find_all?customer_id=17'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.length).to eq(2)
    expect(json[0]['id']).to eq(invoice1.id)
    expect(json[1]['id']).to eq(invoice3.id)
  end
  it 'can find a random invoice' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    invoice1 = Invoice.create!(customer_id: 17, merchant_id: merchant1.id, status: 'pending')
    invoice2 = Invoice.create!(customer_id: 18, merchant_id: merchant2.id, status: 'shipped')
    invoice3 = Invoice.create!(customer_id: 19, merchant_id: merchant3.id, status: 'shipped')

    get '/api/v1/invoices/random'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect([invoice1.id, invoice2.id, invoice3.id]).to include(json[0]['id'])
  end
  it 'can return associated merchants' do
    merchant = create(:merchant)
    invoice = Invoice.create!(customer_id: 17, merchant_id: merchant.id, status: 'pending')

    get "/api/v1/invoices/#{invoice.id}/merchant"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
end
