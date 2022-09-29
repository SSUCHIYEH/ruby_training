FactoryBot.define do
  factory :task do
    title { Faker::Hobby.activity }
    content { Faker::Lorem.sentence }
    start_time { Faker::Date.in_date_period(year: 2022, month: 9) }
    end_time { Faker::Date.in_date_period(year: 2022, month: 10) }

    trait :init do
      status { 'not_started' }
      priority { 'medium' }
    end

    trait :important do
      status { 'in_progress' }
      priority { 'high' }
    end

    trait :next_year do
      start_time { Faker::Date.in_date_period(year: 2023, month: 9) }
      end_time { Faker::Date.in_date_period(year: 2023, month: 10) }
    end

    trait :complete do
      status { 'complete' }
    end

    trait :high do
      priority { 'high' }
    end

    trait :low do
      priority { 'low' }
    end
  end
end
