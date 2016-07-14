# frozen_string_literal: true
FactoryGirl.define do
  factory :engagement do
    id { SecureRandom.hex(3) }
  end
end
