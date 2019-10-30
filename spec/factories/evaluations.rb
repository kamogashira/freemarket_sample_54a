FactoryBot.define do
  factory :evaluation do
    user_id { "1" }
    product_id { "1"}
    good { "3" }
    normal { "2" }
    bad { "1" }
    comment { "MyString" }

    association :user
    association :product
  end
end
