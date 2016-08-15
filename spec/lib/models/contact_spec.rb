require 'spec_helper'

RSpec.describe Contact, type: :model do
  context 'associations' do
    it { should belong_to :owner }
    it { should have_many :engagements }
    it { should have_many :deal_contacts }
    it { should have_many(:deals).through(:deal_contacts) }
    it { should have_many :engagement_contacts }
    it { should have_many(:engagements).through(:engagement_contacts) }
  end

  describe '#formatted_owner' do
    let(:contact) { create(:contact_with_owner) }
    it {expect(contact.formatted_owner).to eq ("#{contact.owner.first} #{contact.owner.last}") }
  end

  describe "#full_name" do
    let(:contact) { create(:contact) }
    it {expect(contact.full_name).to eq ("#{contact.first} #{contact.last}") }
  end

  xdescribe "#add_to_master_table" do
    let(:contact) { create(:contact) }

    it 'calls new on contact params class & creates a new master contact record' do
      expect(MasterTable::ContactParams).to receive(:new).with(contact)
      expect(MasterContact).to receive(:create)
      contact.add_to_master_table
    end
  end

end
