class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images

  belongs_to :category
  has_many :comments
  has_one :evaluation
  belongs_to :brand, optional: true
  belongs_to :size, optional: true
  belongs_to :seller, class_name: "User" ,optional: true
  belongs_to :buyer, class_name: "User",optional: true

  validates :name, length: { in: 1..40}, presence: true
  validates :description, length: { in: 1..1000}, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 300, less_than: 9999999}

  # 商品の状態   0:新品、未使用 1: 未使用に近い 2:目立った傷や汚れなし 3:やや傷や汚れあり 4:やや傷や汚れあり 5:全体的に状態が悪い
  enum condition: { unused: 0, almost_new: 1, normal: 2, a_little_dirty: 3, dirty: 4, bad: 5 }
  # 配送料の負担   0:送料込み(出品者負担) 1: 着払い(購入者負担)
  enum shipping_charge: { sender_expense: 0, receiver_expense: 1 }
  # 配送の方法   0:未定 1: クロネコヤマト 2:ゆうパック 3:ゆうメール
  enum shipping_method: { unknown: 0, kuroneko: 1, yupack: 2, yumail: 3 }
  # 配送までの日数   0:1〜2日で発送 1: 2〜3日で発送 2:4〜7日で発送
  enum shipping_days: { immediately: 0, a_few_days: 1, four_to_seven_days: 2 }
  # 商品のステータス   0:出品中 1: 取引中 2:売却済み
  enum current_status: { selling: 0, trading: 1, completed: 2 }

end
