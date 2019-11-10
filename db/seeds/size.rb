#sizeデータ作成
sizelist = ["XXS以下", "XS(SS)", "S", "M", "L", "XL(LL)", "2XL(3L)", "3XL(4L)", "4XL(5L)以上", "FREE SIZE"]
sizelist. each do |size|
  Size.create!(name: size)
end