FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name + Faker::Name.last_name }
    password { Faker::Coffee.variety }
    role { Faker::Number.between(from: 0, to: 1) }

    trait :normal do
      name { "NORMAL" }
      password { 'password1' }
      role { 0 }
    end

    trait :admin do
      name { "ADMIN" }
      password { 'password1' }
      role { 1 }
    end
  end
end
