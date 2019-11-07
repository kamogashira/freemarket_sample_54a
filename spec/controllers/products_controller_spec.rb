require 'rails_helper'

describe ProductsController, type: :controller do
  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  #今回はインスタンス変数@productのみ確認済みです。その他のテストコードは別途作成予定です。
  describe 'GET #show' do
    it "assigns the requested product to @product" do
      category = create(:category)
      prefecture = create(:prefecture)
      product = create(:product, category_id: category.id)
      get :show, params: { id: product }
      expect(assigns(:product)).to eq product
    end

    it "renders the :show template" do
      product = create(:product)
      get :show, params: { id: product }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it "renders the :edit template" do
      product = create(:product)
      get :edit, params: { id: product }
      expect(response).to render_template :edit
    end
  end
end