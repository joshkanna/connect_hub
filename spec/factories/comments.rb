# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user
    post
  end
end
