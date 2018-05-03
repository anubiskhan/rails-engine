require 'rails_helper'

describe Customer do
  context 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
end
