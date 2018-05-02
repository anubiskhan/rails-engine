require 'rails_helper'

describe 'invoices API' do
  it 'sends all invoices' do
    create_list(:invoice, 10)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.length).to eq(10)
  end
  it 'sends an invoice' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['customer_id']).to eq(invoice.customer_id)
    expect(json['merchant_id']).to eq(invoice.merchant_id)
  end
  it 'can find an invoice by id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by customer id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by merchant id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by status' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by created at' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by updated at' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find all invoices by merchant id' do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 10, merchant_id: merchant.id)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    invoices.each_with_index do |invoice, index|
      expect(json[index]['id']).to eq(invoice.id)
    end
  end
  it 'can find all invoices by a different parameter' do
    customer = create(:customer)
    good_invoices = create_list(:invoice, 6, customer_id: customer.id)
    bad_invoices  = create_list(:invoice, 3)

    get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.length).to eq(6)
    good_invoices.each_with_index do |invoice, index|
      expect(json[index]['id']).to eq(invoice.id)
    end
  end
  it 'can find a random invoice' do
    invoice = create(:invoice)

    get '/api/v1/invoices/random'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
  it 'can return associated merchant' do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'can return associated customer' do
    customer = create(:customer)
    invoice  = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(customer.id)
  end
end
