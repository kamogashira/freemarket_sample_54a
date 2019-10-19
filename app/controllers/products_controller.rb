class ProductsController < ApplicationController
  before_action :set_category, only: :index
  before_action :set_brand, only: :index

  def index
  end
  
  def new
    @product = Product.new
    render layout: 'products_application'
  end

  def set_category
    parents = (1..13).to_a
    parents.each do |parent|
      children = Category.where('ancestry LIKE(?)', "#{parent}/%")
      ids = []
      children.each do |child|
        ids << child[:id]
      end
      products = Product.where(category_id: ids).order("id DESC").limit(10)
      instance_variable_set("@category#{parent}", products)
    end
  end

  def set_brand
    parents = (1..4).to_a
    parents.each do |parent|
      children = Brand.where("(id = ?) OR (ancestry = ?)", parent, parent)
      brands = []
      children.each do |child|
        brands << child[:name]
      end
      products = Product.where(brand_id: brands).order("id DESC").limit(10)
      instance_variable_set("@brand#{parent}", products)
    end
  end
end

