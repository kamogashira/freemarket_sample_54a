require 'rails_helper'

describe ProductsController, type: :controller do
  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested product to @product" do
      product = create(:product, password: "123456789")
      get :show, params: { id: product }
      expect(assigns(:product)).to eq product
    end

    # it "renders the :index template" do
    #   get :show
    #   expect(response).to render_template :show
    # end
  end
end