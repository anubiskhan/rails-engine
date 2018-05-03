require 'rails_helper'

describe Transaction do
  context 'relationships' do
    it { should belong_to(:invoice) }
  end
end
