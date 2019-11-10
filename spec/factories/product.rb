FactoryBot.define do

  factory :product do
    name              {"Spec-TEST"}
    price             {"10000"}
    description       {"少し傷があります"}
    category_id       { category.id }
    brand_id          {""}
    size_id           {""}
    condition         { 0 }
    shipping_charge   { 0 }
    ship_from         { 1 }
    shipping_days     { 0 }
    shipping_method   { 0 }
    current_status    { 0 }
    buyer_id          {""}
    seller_id         {""}
    payment_method    { 0 }
    payment_status    { 0 }
    sending_status    { 0 }
    receiving_status  { 0 }
    like              {""}

    association :category
    association :seller

  end

end