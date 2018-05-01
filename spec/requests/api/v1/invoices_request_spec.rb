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
    expect(json["customer_id"]).to eq(invoice.customer_id)
    expect(json["merchant_id"]).to eq(invoice.merchant_id)
  end
  it 'can find an invoice by id' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: "pending")

    get "/api/v1/invoices/find?id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
  it 'can find an invoice by customer id' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: "pending")

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
  it 'can find an invoice by merchant id' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: "pending")

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
  it 'can find an invoice by status' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: "pending")

    get "/api/v1/invoices/find?status=#{invoice.status}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
  it 'can find an invoice by created at' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: "pending")

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
  it 'can find an invoice by updated at' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: "pending")

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(invoice.id)
  end
end
