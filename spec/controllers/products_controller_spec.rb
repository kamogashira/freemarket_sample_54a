require 'rails_helper'

describe ProductsController, type: :controller do
  
  before do
    prefecture = create(:prefecture)
    @product = create(:product)
  end

  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    it "assigns the requested product to @product" do
      get :show, params: { id: @product }
      expect(assigns(:product)).to eq @product
    end

    it "renders the :show template" do
      get :show, params: { id: @product }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do

    it "renders the :edit template" do
      get :edit, params: { id: @product }
      expect(response).to render_template :edit
    end
  end
end