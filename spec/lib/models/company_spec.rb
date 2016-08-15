require 'spec_helper'

RSpec.describe Company, type: :model do
  context 'associations' do
    it { should have_many :company_deals }
    it { should have_many(:deals).through(:company_deals) }
    it { should have_many :company_engagements }
    it { should have_many(:engagements).through(:company_engagements) }
  end
end
