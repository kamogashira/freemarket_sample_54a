#テスト用product_imageデータ作成
1.upto(9) do |n|
  ProductImage.create!(product_id: n,
               image: open("#{Rails.root}/db/fixtures/img#{n}.jpg")
              )
end