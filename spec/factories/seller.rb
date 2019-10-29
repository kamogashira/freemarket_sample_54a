FactoryBot.define do
  factory :seller, class: User do
    password = Faker::Internet.password
    email = Faker::Internet.email
    email                  {email}
    encrypted_password     {password}
    reset_password_token   {password}
    reset_password_sent_at {"2019-01-01"}
    remember_created_at    {"2019-01-01"}
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