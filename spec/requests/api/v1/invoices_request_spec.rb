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
end
