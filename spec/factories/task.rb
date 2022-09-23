require 'rails_helper'
require 'faker'

FactoryBot.define do
  factory :task do
    title { Faker::Hobby.activity }
    content { Faker::Lorem.sentence }
    start_time { Faker::Date.forward(days: 23) }
    end_time { Faker::Date.forward(days: 23) }
    status { 'NotStarted' }
    priority { 'High' }

    trait :init do
      status { 'NotStarted' }
      priority { 'Medium' }
    end

    trait :important do
      status { 'InProgress' }
      priority { 'High' }
    end
  end
end
