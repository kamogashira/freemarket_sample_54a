#テスト用productデータ作成
1.upto(8) do |n|
  Product.create!(name: "TEST#{n}",
                  price: n*1000,
                  description: "新品・未使用です",
                  category_id: n+100,
                  brand_id: n,
                  size_id: "",
                  condition: 1,
                  shipping_charge: n%2,
                  ship_from: n,
                  shipping_days: n%3,
                  shipping_method: n%4,
                  current_status: 0,
                  buyer_id: 1,
                  seller_id: 1,
                  payment_method: 0,
                  payment_status: 0,
                  sending_status: 0,
                  receiving_status: 0,
                  like: n
              )
end