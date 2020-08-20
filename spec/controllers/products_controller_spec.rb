require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      category = Category.create name: 'Laptop'
      post :create, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
      expect(Product.count).to eql(1)
    end

    it "returns http success" do
      category = Category.create name: 'Laptop'
      post :create, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #index" do
    it "assigns @products" do
      category = Category.create name:'Laptop'
      get :index, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
      expect(assigns(:products))
    end

     it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
