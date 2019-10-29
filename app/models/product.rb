class Product < ApplicationRecord
  has_many :product_images

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

end
