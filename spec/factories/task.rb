FactoryBot.define do
  factory :task do
    title { Faker::Hobby.activity }
    content { Faker::Lorem.sentence }
    start_time { Faker::Date.in_date_period(year: 2022, month: 9) }
    end_time { Faker::Date.in_date_period(year: 2022, month: 10) }
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

    trait :period_error do
      start_time { Faker::Date.in_date_period(year: 2022, month: 10) }
      end_time { Faker::Date.in_date_period(year: 2022, month: 9) }
    end
  end
end
