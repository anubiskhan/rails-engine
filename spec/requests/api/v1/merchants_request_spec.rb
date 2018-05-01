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
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['id']).to eq(id)
  end
  it 'creates a new merchant' do
    merchant_params = { name: 'Newbie' }

    post '/api/v1/merchants', params: { merchant: merchant_params }

    merchant = Merchant.last

    expect(response).to be_success
    expect(merchant.name).to eq(merchant_params[:name])
  end
end
