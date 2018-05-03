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
    expect(json[0]["id"]).to eq(invoice.id)
  end
  it 'sends the associated merchant' do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end
  it 'sends the associated customer' do
    customer = create(:customer)
    invoice  = create(:invoice, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(customer.id)
  end
  it 'sends all associated transactions' do
    invoice      = create(:invoice)
    transactions = create_list(:transaction, 10, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    json = JSON.parse(response.body)

    expect(response).to be_success
    transactions.each_with_index do |transaction, index|
      expect(json[index]["id"]).to eq(transaction.id)
    end
  end
  it 'sends all associated invoice items' do
    invoice       = create(:invoice)
    invoice_items = create_list(:invoice_item, 10, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    json = JSON.parse(response.body)

    expect(response).to be_success
    invoice_items.each_with_index do |invoice_item, index|
      expect(json[index]["id"]).to eq(invoice_item.id)
    end
  end
  it 'sends all associated items' do
    invoice = create(:invoice)
    item_1  = create(:item)
    item_2  = create(:item)
    item_3  = create(:item)
    items   = [item_1, item_2, item_3]
    create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
    create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id)
    create(:invoice_item, invoice_id: invoice.id, item_id: item_3.id)

    get "/api/v1/invoices/#{invoice.id}/items"

    json = JSON.parse(response.body)

    expect(response).to be_success
    items.each_with_index do |item, index|
      expect(json[index]["id"]).to eq(item.id)
    end
  end
end
