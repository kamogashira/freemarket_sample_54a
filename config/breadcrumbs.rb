# ルート
crumb :root do
  link "メルカリ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", users_path
end

# プロフィール
crumb :profile do
  link "プロフィール", edit_user_path
end

# 出品中商品一覧
crumb :selling do
  link "出品した商品-出品中", selling_users_path
  parent :mypage
end

# 出品中商品
crumb :selling_item do
  link "出品商品画面", selling_users_path
  parent :selling
end

# 取引中商品一覧
crumb :trading do
  link "出品した商品-取引中", trading_users_path
  parent :mypage
end

# 取引中商品
crumb :trading_item do
  link "取引中商品", trading_users_path
  parent :trading
end

# 売却済み商品一覧
crumb :completed do
  link "出品した商品-売却済み", completed_users_path
  parent :mypage
end

# 売却済み商品
crumb :completed_item do
  link "売却済み商品", completed_users_path
  parent :completed
end

# 発送元・お届け先住所変更
crumb :address do
  link "発送元・お届け先住所変更", new_user_delivery_address_path
  parent :mypage
end

