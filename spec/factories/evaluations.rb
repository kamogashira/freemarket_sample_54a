FactoryBot.define do
  factory :evaluation do
    user { nil }
    product { nil }
    good { 1 }
    normal { 1 }
    bad { 1 }
    comment { "MyString" }
  end
end
