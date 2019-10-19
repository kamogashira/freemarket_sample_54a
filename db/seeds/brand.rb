parents = ["シャネル", "ナイキ", "ルイ ヴィトン", "シュプリーム"]
parents.each do |parent|
  parent = Brand.create(name: parent)
end

#各ブランドの子カテゴリーに表記違いバージョンを作成

#シャネルの子カテゴリー配列
chanel_children = ['Chanel', 'chanel']
chanel_children.each do |child|
  child = Brand.find_by(name: 'シャネル').children.create(name: child)
end

#ナイキの子カテゴリー配列
nike_children = ['NIKE']
nike_children.each do |child|
  child = Brand.find_by(name: 'ナイキ').children.create(name: child)
end

#ルイ ヴィトンの子カテゴリー配列
vuitton_children = ['ルイヴィトン', 'ヴィトン', 'LOUIS VUITTON', 'Louis Vuitton']
vuitton_children.each do |child|
  child = Brand.find_by(name: 'ナイキ').children.create(name: child)
end

#シュプリームの子カテゴリー配列
supreme_children = ['Supreme', 'supreme']
supreme_children.each do |child|
  child = Brand.find_by(name: 'シュプリーム').children.create(name: child)
end