require 'spec_helper'

RSpec.describe DealContact, type: :model do
  context 'associations' do
    it { should belong_to :deal }
    it { should belong_to :contact }
  end
end
