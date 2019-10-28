FactoryBot.define do
  factory :comment do
    product { nil }
    user { nil }
    content { "MyText" }
  end
end
