# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bproduct do
    user { association :user }
    name { 'Cella' }
    price { '6780' }
    location { '9008' }
    category_id { '6' }
    condition_id { '2' }
  end
end
