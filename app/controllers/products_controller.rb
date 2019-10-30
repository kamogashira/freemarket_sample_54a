class ProductsController < ApplicationController
  before_action :set_category, only: :index
  before_action :set_brand, only: :index

  def index
  end

  def show
    @product = Product.find(params[:id])
    @product_images = @product.product_images
    @ship_from = Prefecture.find(@product.ship_from).name
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
    @user = @product.seller
    @products_related_user = Product.where(seller_id: @user.id).limit(6)
    @products_related_category = Product.where(category_id: @product.category_id).limit(6)

    # 商品の状態   0:新品、未使用 1: 未使用に近い 2:目立った傷や汚れなし 3:やや傷や汚れあり 4:やや傷や汚れあり 5:全体的に状態が悪い
    @condition = @product.condition_i18n
    # if  @product.condition == 0 
    #   @condition = "新品、未使用"
    # elsif  @product.condition == 1
    #   @condition = "未使用に近い"
    # elsif  @product.condition == 2
    #   @condition = "目立った傷や汚れなし"
    # elsif  @product.condition == 3
    #   @condition = "やや傷や汚れあり"
    # elsif  @product.condition == 4
    #   @condition = "やや傷や汚れあり"
    # else
    #   @condition = "全体的に状態が悪い"
    # end

    # 配送料の負担   0:送料込み(出品者負担) 1: 着払い(購入者負担)
    @shipping_charge = @product.shipping_charge_i18n
    # if  @product.shipping_charge == 0 
    #   @shipping_charge = "送料込み(出品者負担)"
    # else
    #   @shipping_charge = "着払い(購入者負担)"
    # end

    # 配送の方法   0:未定 1: クロネコヤマト 2:ゆうパック 3:ゆうメール
    @shipping_method = @product.shipping_method_i18n
    # if  @product.shipping_method == 0 
    #   @shipping_method = "未定"
    # elsif  @product.shipping_method == 1
    #   @shipping_method = "クロネコヤマト"
    # elsif  @product.shipping_method == 2
    #   @shipping_method = "ゆうパック"
    # else
    #   @shipping_method = "ゆうメール"
    # end

    # 配送までの日数   0:1〜2日で発送 1: 2〜3日で発送 2:4〜7日で発送
    @shipping_days = @product.shipping_days_i18n
    # if  @product.shipping_days == 0 
    #   @shipping_days = "1〜2日で発送"
    # elsif  @product.shipping_days == 1
    #   @shipping_days = "2〜3日で発送"
    # else  @product.shipping_days == 2
    #   @shipping_days = "4〜7日で発送"
    # end
    
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
    #2440: シャネル 6142: ルイ ヴィトン 6758: シュプリーム 3802: ナイキ
    main_brand_ids = [2440, 6142, 6758, 3802]
    main_brand_ids.each do |brand|
      products = Product.where(brand_id: brand).order("id DESC").limit(10)
      instance_variable_set("@brand#{brand}", products)
    end
  end
end

