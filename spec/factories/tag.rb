FactoryBot.define do
  factory :tag do
    name { Faker::Hobby.activity }
    trait :work do
      name { 'WORK' }
    end
  end
end
