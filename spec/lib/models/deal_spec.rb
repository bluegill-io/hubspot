require 'spec_helper'

RSpec.describe Deal, type: :model do
  context 'associations' do
    it { should belong_to :deal_stage }
    it { should have_many :company_deals }
    it { should have_many(:companies).through(:company_deals) }
    it { should have_many(:contacts).through(:deal_contacts) }
    it { should have_many :engagement_deals }
    it { should have_many(:engagements).through(:engagement_deals) }
  end
end
