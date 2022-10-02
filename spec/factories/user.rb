FactoryBot.define do
    factory :user do
      name { Faker::Name.first_name + Faker::Name.last_name }
      password { Faker::Coffee.variety }
      role { Faker::Number.between(from: 0, to: 1) }

      trait :first do
        name { "NormalFirst" }
        password { 'password1' }
        role { 0 }
      end
    end
  end
  