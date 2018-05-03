require 'rails_helper'

describe Merchant do
  context 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end
end
