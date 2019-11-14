class UserAddressesController < ApplicationController
  def new
    if UserAddress.where(user_id: params[:user_id]).present?
      @user_address = UserAddress.find_by(user_id: params[:user_id])
    else
      @user_address = UserAddress.new
    end
  end

  def create
    @user_address = UserAddress.new(user_address_params)
    if @user_address.save
      redirect_to action: :new
    else
      render "new"
    end
  end

  def update
    @user_address = UserAddress.find(params[:id])
    if @user_address.update(user_address_params)
      redirect_to new_user_user_address_path, notice: "変更されました"
    else
      render "new"
    end
  end

  private

  def user_address_params
    params.require(:user_address).permit(:postal_code, :prefecture_id, :address_city, :address_street, :address_building)
  end
end
