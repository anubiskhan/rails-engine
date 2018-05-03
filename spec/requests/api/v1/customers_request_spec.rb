require 'rails_helper'

describe 'customers API' do
  it 'sends all customers' do
    create_list(:customer, 5)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq(5)
  end
  it 'sends one customer by id' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['id']).to eq(customer.id)
    expect(json['first_name']).to eq(customer.first_name)
  end
  it 'finds one customer by id' do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(customer.id)
  end
  it 'finds one customer by first name' do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(customer.id)
  end
  it 'finds one customer by last name' do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(customer.id)
  end
  it 'finds one customer by created at' do
    customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(customer.id)
  end
  it 'finds one customer by updated at' do
    customer = create(:customer)

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(customer.id)
  end
  it 'finds all customers by id' do
    customer = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer.id}"

    json = JSON.parse(response.body)

    expect(json[0]["id"]).to eq(customer.id)
  end
  it 'finds all customers by first name' do
    customers = create_list(:customer, 10)

    get "/api/v1/customers/find_all?first_name=#{customers.first.first_name}"

    json = JSON.parse(response.body)

    customers.each_with_index do |customer, index|
      expect(json[index]["id"]).to eq(customer.id)
    end
  end
  it 'sends a random customer' do
    customer = create(:customer)

    get '/api/v1/customers/random'

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(customer.id)
  end
  it 'sends customer invoices' do
    customer = create(:customer)
    invoice1 = create(:invoice, customer_id: customer.id)
    invoice2 = create(:invoice, customer_id: customer.id)
    invoice3 = create(:invoice, customer_id: customer.id)
    create(:invoice)

    get "/api/v1/customers/#{customer.id}/invoices"

    json = JSON.parse(response.body)

    expect(json.length).to eq(3)
    expect(json[0]["id"]).to eq(invoice1.id)
    expect(json[1]["id"]).to eq(invoice2.id)
    expect(json[2]["id"]).to eq(invoice3.id)
  end
end
