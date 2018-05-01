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
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')

    get "/api/v1/invoices/find?id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by customer id' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by merchant id' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by status' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')

    get "/api/v1/invoices/find?status=#{invoice.status}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by created at' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find an invoice by updated at' do
    invoice = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(invoice.id)
  end
  it 'can find all invoices by merchant id' do
    invoice1 = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')
    invoice2 = Invoice.create!(customer_id: 18, merchant_id: 71, status: 'success')

    get '/api/v1/invoices/find_all?merchant_id=71'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]['id']).to eq(invoice1.id)
    expect(json[1]['id']).to eq(invoice2.id)
  end
  it 'can find all invoices by a different parameter' do
    invoice1 = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')
    Invoice.create!(customer_id: 18, merchant_id: 71, status: 'success')
    invoice3 = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'success')

    get '/api/v1/invoices/find_all?customer_id=17'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.length).to eq(2)
    expect(json[0]['id']).to eq(invoice1.id)
    expect(json[1]['id']).to eq(invoice3.id)
  end
  it 'can find a random invoice' do
    invoice1 = Invoice.create!(customer_id: 17, merchant_id: 71, status: 'pending')
    invoice2 = Invoice.create!(customer_id: 18, merchant_id: 72, status: 'success')
    invoice3 = Invoice.create!(customer_id: 19, merchant_id: 73, status: 'success')

    get '/api/v1/invoices/random'

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect([invoice1.id, invoice2.id, invoice3.id]).to include(json[0]['id'])
  end
end
