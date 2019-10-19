FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    password { "0000000a" }
    password_confirmation { "0000000a" }
  end
end