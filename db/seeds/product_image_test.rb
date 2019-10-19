#テスト用product_imageデータ作成
1.upto(8) do |n|
  ProductImage.create!(product_id: n,
               image: open("#{Rails.root}/db/fixtures/img#{n}.jpg")
              )
end