FactoryBot.define do

  factory :product do
    name              {"Spec-TEST"}
    price             {"10000"}
    description       {"少し傷があります"}
    category_id       {"158"}
    brand_id          {"1"}
    size_id           {""}
    condition         {"未使用に近い"}
    shipping_charge   {"送料込み(出品者負担)"}
    ship_from         {"1"}
    shipping_days     {"1~2日で発送"}
    current_status    {"0"}
    buyer_id          {""}
    seller_id         {""}
    payment_method    {"0"}
    payment_status    {"0"}
    sending_status    {"0"}
    receiving_status  {"0"}
    like              {""}

    association :category
    association :seller

  end

end