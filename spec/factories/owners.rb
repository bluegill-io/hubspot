# frozen_string_literal: true
FactoryGirl.define do
  factory :owner do
    id { SecureRandom.hex(3) }
    sequence(:first) { |n| "First#{n}" }
    sequence(:last) { |n| "Last#{n}" }
    sequence(:email) { |n| "email#{n}@foobar.com" }
  end
end
