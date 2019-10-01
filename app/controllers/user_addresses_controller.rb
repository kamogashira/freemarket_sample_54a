class UserAddressesController < ApplicationController
  def index
    @user_address = UserAddress.new
  end

  def create
    @user_address = UserAddress.new(user_address_params)
    if @user_address.save
    # binding.pry
      redirect_to action: :index
    else
      render "index", notice: "変更できませんでした"
    end
  end

  private

  def user_address_params
    params.require(:user_address).permit(:postal_code, :prefecture_id, :address_city, :address_street, :address_building)
  end
end
