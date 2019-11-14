class DeliveryAddressesController < ApplicationController
  before_action :set_user

  def new
    if DeliveryAddress.where(user_id: params[:user_id]).present?
      @delivery_address = DeliveryAddress.find_by(user_id: params[:user_id])
    else
      @delivery_address = DeliveryAddress.new
    end
  end

  def create
    @delivery_address = DeliveryAddress.new(delivery_address_params)
    if @delivery_address.save
      redirect_to action: :new
    else
      render "new"
    end
  end

  def update
    @delivery_address = DeliveryAddress.find(params[:id])
    if @delivery_address.update(delivery_address_params)
      redirect_to new_user_delivery_address_path, notice: "変更されました"
    else
      render "new"
    end
  end

  def set_user
    @user = current_user
  end

  private

  def delivery_address_params
    params.require(:delivery_address).permit(:first_name, :last_name, :first_name_kana, :postal_code, :last_name_kana, :prefecture_id, :address_city, :address_street, :address_building).merge(user_id:current_user.id)
  end
end
