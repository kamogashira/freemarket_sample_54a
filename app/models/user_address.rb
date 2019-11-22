class UserAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  # validates :postal_code,            presence: true, on: :save_phone_to_session
  
  with_options on: :register do
    validates :postal_code,            presence: true
    validates :prefecture_id,          presence: true
    validates :address_city,           presence: true
    validates :address_street,         presence: true
  end
end
