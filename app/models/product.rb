class Product < ApplicationRecord
  has_many :product_images
  belongs_to :category
  has_many :comments
  has_one :evaluation
  belongs_to :brand, optional: true
  belongs_to :size, optional: true
end
