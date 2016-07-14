# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Api::Engagements do
  subject { described_class.new }

  describe '#initialize' do
    it { expect(subject.url).to eq 'https://api.hubapi.com/engagements/v1/engagements/recent/modified?' }
    it { expect(subject.needs_joins).to eq true }
    it { expect(subject.hash_access).to eq 'results' }
  end

  describe '#check_offset' do
    context 'response has more records' do
      let(:response) { OpenStruct.new('hasMore': true) }
      it { expect(subject.check_offset(response)).to eq true }
    end

    context 'response has no more records' do
      let(:false_response) { OpenStruct.new('hasMore': false) }
      it { expect(subject.check_offset(false_response)).to eq false }
    end
  end

  describe '#params' do
    it { expect(subject.params).to eq init_params }
  end

  describe '#format_params' do
    it { expect(subject.format_params).to eq engagement_params }
  end

  describe '#rerun' do
    let(:resp) { OpenStruct.new('offset': 51) }

    it 'calls retreive with offset number from response' do
      expect(subject).to receive(:retreive).with(init_params.merge(offset: '51'))
      subject.rerun(resp)
    end
  end

  describe '#process_joins' do
    let(:engagement) { create(:engagement) }
    context 'the association array is empty' do
      it 'does not save a new association record' do
        subject.process_joins(engagement.id, empty_association_json)
        expect(EngagementContact.count).to eq 0
      end
    end

    context 'the association array is not empty' do
      it 'saves a new association record' do
        subject.process_joins(engagement.id, association_json)
        expect(EngagementDeal.count).to eq 2
        expect(CompanyEngagement.count).to eq 1
      end
    end
  end

  def association_json
    OpenStruct.new("associations.companyIds": [23_432],
                   "associations.dealIds": [13_434, 32_434])
  end

  def empty_association_json
    OpenStruct.new("associations.contactsIds": [])
  end

  def init_params
    { hapikey: 'test',
      property: 'id;createdBy;createdAt;contactsIds;companyIds;dealsIds;body',
      count: '50' }
  end

  def engagement_params
    {
      id: :"engagement.id",
      post_at: :"engagement.createdAt",
      body: :"metadata.body",
      owner_id: :"engagement.createdBy"
    }
  end
end
