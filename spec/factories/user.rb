FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name + Faker::Name.last_name }
    password { Faker::Coffee.variety }
    role { Faker::Number.between(from: 0, to: 1) }

    trait :normal do
      name { "NORMAL" }
      role { 0 }
    end

    trait :admin do
      name { "ADMIN" }
      role { 1 }
    end
  end
end
