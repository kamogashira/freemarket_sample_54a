class Product < ApplicationRecord
  has_many :product_images
  has_many :comments
  has_one :evaluation
  belongs_to :category
  belongs_to :size
end
