# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Api::Owners do
  subject { described_class.new }

  describe '#initialize' do
    it { expect(subject.url).to eq 'https://api.hubapi.com/owners/v2/owners/?' }
    it { expect(subject.needs_joins).to eq false }
    it { expect(subject.hash_access).to eq '' }
  end

  describe '#params' do
    it { expect(subject.params).to eq(hapikey: 'test') }
  end

  describe '#format_params' do
    it { expect(subject.format_params).to eq owner_params }
  end

  def owner_params
    {
      id: :ownerId,
      first: :firstName,
      last: :lastName,
      email: :email
    }
  end
end
