class ProductsController < ApplicationController
  
  def index
  end

  def new
    @product = Product.new
    render layout: 'products_application'
  end

  def show
  end

  def user_address_params
    params.require(:user_address).permit(:postal_code, :prefecture_id, :address_city, :address_street, :address_building)
  end

end
