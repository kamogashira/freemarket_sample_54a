FactoryBot.define do
  factory :category do
    name {"レディース"}

    factory :category_child do |f|
      f.name {"トップス"}
      f.parent {FactoryBot.create(:category)}
      
      factory :category_grandchild do |f|
        f.name {"半袖"}
        f.parent {FactoryBot.create(:category_child)}
      end
    end
  end
end