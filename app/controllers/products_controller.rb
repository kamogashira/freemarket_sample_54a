class ProductsController < ApplicationController
  before_action :set_category, only: [:index, :new, :edit, :update]
  before_action :set_brand, only: :index
  before_action :set_product_info, only:[:show, :show_mine, :edit]

  def index
  end

  def new
    @product = Product.new
    render layout: 'products_application'
  end

  def show
  end

  def show_mine
  end

  def edit
  end

  def update
    product = Product.find(params[:id])
    # if product.seller == current_user.id  //ログイン機能実装後に追記

     # 商品のサイズとブランド以外を更新
    product.update(product_params)

    # 商品のサイズを更新
    if params.require(:product)[:size_id] != nil
      selected_size = Size.where(name: params[:size_id])
      new_size_id = selected_size.ids
      product.update(size_id: new_size_id[0])
    end

    # 商品のブランドを更新
    if params.require(:product)[:brand_id] != nil
      selected_brand = Brand.where(name: params.require(:product)[:brand_id])
      new_brand_id = selected_brand.ids
      product.update(brand_id: new_brand_id[0])
    end

    redirect_to show_mine_product_path
    # end
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
      @category_parent_array << parent  #親カテゴリー
    end
    @category_children_default = @product.category.root.children #表示している商品に紐付く子カテゴリー
    @category_grandchildren_default = @product.category.siblings #表示している商品に紐付く孫カテゴリー
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

  # 親カテゴリーが選択された後に動くアクション/formatはjson
  def get_category_children
    # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション/formatはjson
  def get_category_grandchildren
  # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  # 孫カテゴリーが選択された後に動くアクション/formatはjson
  def get_size
    # サイズ一覧の配列を取得
    @sizelist = Size.all
  end

end

private
def product_params
  params.require(:product).permit(:name, :description, :category_id, :condition, :shipping_charge, :ship_from, :shipping_days, :price)
end

