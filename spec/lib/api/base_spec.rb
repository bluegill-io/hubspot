# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Api::Base do
  subject { described_class.new('url') }

  describe '#initialize' do
    it { expect(subject.url).to eq 'url' }
    it { expect(subject.key).to_not be_empty }
    it { expect(subject.hash_access).to eq 'results' }
    it { expect(subject.needs_joins).to eq false }
  end

  describe '#check_offset' do
    it 'defaults to false' do
      expect(subject.check_offset).to eq false
    end
  end

  describe '#params' do
    context 'no children params' do
      it 'sets key/value pair for only the api key' do
        expect(subject.params).to eq(hapikey: subject.key)
      end
    end

    context 'children params exist' do
      it 'sets proper key/value pairs' do
        options = { foo: 'bar', hello: 'world' }
        expect(subject.params(options)).to eq({ hapikey: subject.key }.merge(options))
      end
    end
  end
end
