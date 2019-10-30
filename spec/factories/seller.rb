FactoryBot.define do
  factory :seller, class: User do
    password = Faker::Internet.password

    password              { password }
    password_confirmation { password }
    sequence(:email)      { |n| "foo#{n}@bar.com" }
    nickname               { "seller" }
    first_name             { "seller" }
    last_name              { "seller" }
    first_name_kana        { "seller" }
    last_name_kana         { "seller" }
    birthday               { "2019-01-01" }
    self_introduction      { "" }
    provider               { "" }
    uid                    { "" }
  end
end