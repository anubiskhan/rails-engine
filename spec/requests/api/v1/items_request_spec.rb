require 'rails_helper'

describe 'items API' do
  it 'sends all items' do
    create_list(:item, 10)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.length).to eq(10)
  end
end
