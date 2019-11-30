class ProductsController < ApplicationController
  before_action :set_category, only: [:index, :edit, :update]
  before_action :set_brand, only: :index
  before_action :set_product_info, only:[:show, :show_my_product, :edit]

  def index
  end

  def new
    @product = Product.new
    @product.product_images.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name  #親カテゴリー
    end

  end

  def create
    @product = Product.new(product_params)
    if @product.save
      # 商品の画像を保存
      if params.has_key?(:product_images)
        params[:product_images][:image].each do |image|
          @product_images = @product.product_images.update(image: image, product_id: @product.id)
        end
      end
      # 商品のブランドを保存
      if params.require(:product)[:brand_id] != nil
        selected_brand = Brand.where(name: params.require(:product)[:brand_id])
        new_brand_id = selected_brand.ids
        @product.update(brand_id: new_brand_id[0])
      end
      redirect_to root_path
    else
      redirect_to new_product_path
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def show
  end

  def show_my_product
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
     # 商品のサイズとブランド以外を更新
    @product.update(product_params)

    # 商品の画像を更新
    if params.has_key?(:product_images)
      params[:product_images][:image].each do |image|
        @product_images = @product.product_images.create(image: image, product_id: @product.id)
      end

    end
    # 商品のサイズを更新
    if params.require(:product)[:size_id] != nil
      selected_size = Size.where(name: params[:size_id])
      new_size_id = selected_size.ids
      @product.update(size_id: new_size_id[0])
    end

    # 商品のブランドを更新
    if params.require(:product)[:brand_id] != nil
      selected_brand = Brand.where(name: params.require(:product)[:brand_id])
      new_brand_id = selected_brand.ids
      @product.update(brand_id: new_brand_id[0])
    end
    redirect_to show_my_product_product_path
  end

  def set_product_info
    @product = Product.find(params[:id])
    @product_images = @product.product_images
    @ship_from = Prefecture.find(@product.ship_from).name
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
    @user = @product.seller
    @products_related_user = Product.where(seller_id: @user.id).limit(6)
    @products_related_category = Product.where(category_id: @product.category_id).limit(6)
    @sizelist = Size.all
    @price = @product.price
    @price_fee = ( @price * 0.1 ).round
    @price_profit = @price - @price_fee

    # 商品の状態   0:新品、未使用 1: 未使用に近い 2:目立った傷や汚れなし 3:やや傷や汚れあり 4:やや傷や汚れあり 5:全体的に状態が悪い
    @condition = @product.condition_i18n
    # 配送料の負担   0:送料込み(出品者負担) 1: 着払い(購入者負担)
    @shipping_charge = @product.shipping_charge_i18n
    # 配送の方法   0:未定 1: クロネコヤマト 2:ゆうパック 3:ゆうメール
    @shipping_method = @product.shipping_method_i18n
    # 配送までの日数   0:1〜2日で発送 1: 2〜3日で発送 2:4〜7日で発送
    @shipping_days = @product.shipping_days_i18n

    # 商品情報編集ページ(edit)のセレクトボックス初期値設定
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name  #親カテゴリー
    end

    @category_children_default = []
    @product.category.root.children.each do |child|
      @category_children_default << child  #表示している商品に紐付く子カテゴリー
    end
    
    @category_grandchildren_default = []
    @product.category.siblings.each do |grandchild| 
      @category_grandchildren_default << grandchild  #表示している商品に紐付く孫カテゴリー
    end

    if @product.brand_id != nil
      @brand = @product.brand.name
    else
      @brand = ''
    end
  end

  def set_category
    #トップページに表示する商品のカテゴリー設定
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
    #トップページに表示する商品のブランド設定
    #2440: シャネル 6142: ルイ ヴィトン 6758: シュプリーム 3802: ナイキ
    main_brand_ids = [2440, 6142, 6758, 3802]
    main_brand_ids.each do |brand|
      products = Product.where(brand_id: brand).order("id DESC").limit(10)
      instance_variable_set("@brand#{brand}", products)
    end
  end

  def get_category_children_new
      @category_children_new = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_size_new
    selected_grandchild = Category.find("#{params[:grandchild_id]}")
    if related_size_parent = selected_grandchild.sizes[0] 
      @sizes = related_size_parent.children 
    else
      selected_child = Category.find("#{params[:grandchild_id]}").parent 
      if related_size_parent = selected_child.sizes[0] 
        @sizes = related_size_parent.children 
      end
    end
  end

  def get_category_grandchildren_new
    @category_grandchildren_new = Category.find("#{params[:child_id]}").children
    return @category_grandchildren_new
  end

end

private
def product_params
  params.require(:product).permit(:name, :description, :category_id, :condition, :shipping_charge, :shipping_method, :ship_from, :shipping_days, :current_status, :payment_method, :price, :id, product_images_attributes:[ :image, :id, :_destroy ]).merge(seller_id: current_user.id)
end