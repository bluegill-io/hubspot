# frozen_string_literal: true
FactoryGirl.define do
  factory :contact do
    id { SecureRandom.hex(3) }
    sequence(:first) { |n| "First#{n}" }
    sequence(:last) { |n| "Last#{n}" }
    owner_id { SecureRandom.hex(3) }

    factory :contact_with_owner do
      after(:create) do |c|
        create(:owner, id: c.owner_id)
      end
    end
  end
end
