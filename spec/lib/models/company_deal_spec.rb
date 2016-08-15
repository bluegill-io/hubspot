require 'spec_helper'

RSpec.describe CompanyDeal, type: :model do
  context 'associations' do
    it { should belong_to :company }
    it { should belong_to :deal }
  end
end
