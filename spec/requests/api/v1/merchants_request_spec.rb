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

    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds one merchant by name' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds one merchant by created at' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds one merchant by updated at' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(merchant.id)
  end
  it 'finds all merchants by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(json["id"]).to eq(merchant.id)
  end
end
