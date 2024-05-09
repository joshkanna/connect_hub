# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    id { Faker::Number.number(digits: 2) }
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }
    user
  end
end
