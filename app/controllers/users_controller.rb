class UsersController < ApplicationController
  before_action :set_user, only:[:index, :profile, :edit]
  
  def index
  end

  def profile
  end

  def update
    @user = User.find(params[:id])
    @user.nickname = user_params[:nickname]
    @user.self_introduction = user_params[:self_introduction]
    @user.save(:validate => false)
    redirect_to edit_user_path
  end

  def selling
    @user = current_user
    @products = Product.where('seller_id = ? and current_status = ?', @user.id, 0)
    @status = "出品中"
  end

  def trading
    @user = current_user
    @products = Product.where('seller_id = ? and current_status = ?', @user.id, 1)
    @products.each do |product|
      if ( product.payment_status == 1 && product.sending_status == 0 )
        @status = "発送待ち" 
      else
        @status = "受け取り評価待ち"
      end
    end
  end
  
  def completed
    @user = current_user
    @products = Product.where('seller_id = ? and current_status = ?', @user.id, 2)
    @status = "売却済み"
  end

  def set_user
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :self_introduction)
  end

end