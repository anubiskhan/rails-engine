require 'rails_helper'

describe 'transactions API' do
  it 'sends all transactions' do
    create_list(:transaction, 5)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(5)
  end
  it 'sends one transaction by id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(transaction.id)
  end
  it 'finds one transaction by id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds one transaction by invoice id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds one transaction by credit card number' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds one transaction by credit card expiration date' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{transaction.credit_card_expiration_date}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds one transaction by result' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{transaction.result}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds one transaction by created at' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds one transaction by updated at' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'finds all transactions by id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find_all?id=#{transaction.id}"

    json = JSON.parse(response.body)

    expect(json[0]["id"]).to eq(transaction.id)
  end
  it 'finds all transactions by invoice id' do
    invoice      = create(:invoice)
    transactions = create_list(:transaction, 10, invoice_id: invoice.id)

    get "/api/v1/transactions/find_all?invoice_id=#{transactions.first.invoice_id}"

    json = JSON.parse(response.body)

    transactions.each_with_index do |transaction, index|
      expect(json[index]["id"]).to eq(transaction.id)
    end
  end
  it 'sends a random transaction' do
    transaction = create(:transaction)

    get '/api/v1/transactions/random'

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(transaction.id)
  end
  it 'send transaction invoice' do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(invoice.id)
  end
end
