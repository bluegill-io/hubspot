require 'spec_helper'

RSpec.describe CompanyEngagement, type: :model do
  context 'associations' do
    it { should belong_to :engagement }
    it { should belong_to :company }
  end
end
