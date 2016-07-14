# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Api::Companies do
  subject { described_class.new }

  describe '#hash_access' do
    it { expect(subject.hash_access).to eq 'results' }
  end
end
