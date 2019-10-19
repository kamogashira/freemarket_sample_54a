class UserAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to :user --userモデルを作成したら追記する
  belongs_to :user
  belongs_to_active_hash :prefecture
end
