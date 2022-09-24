FactoryBot.define do
  factory :task do
    title { Faker::Hobby.activity }
    content { Faker::Lorem.sentence }
    start_time { Faker::Date.forward(days: 23) }
    end_time { Faker::Date.forward(days: 23) }
    status { 'notStarted' }
    priority { 'high' }

    trait :init do
      status { 'notStarted' }
      priority { 'medium' }
    end

    trait :important do
      status { 'inProgress' }
      priority { 'high' }
    end
  end
end
