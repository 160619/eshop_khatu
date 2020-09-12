require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "#index" do
    it "assigns products" do
      category = Category.create(name: 'Laptop')
      Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
      get :index
      products = assigns(:products)
      expect(products.size).to eql(1)
    end

     it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    let(:user) do
      User.create(email:'abc@gmail.com', password: '123456', password_confirmation: '123456')
    end

    before do
      sign_in user
    end

    it "assigns a new product to @products" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

     it "renders the new view" do
      get :new
      expect(assigns(:product)).to be_a_kind_of(Product)
    end
  end

  describe "#create" do
    let(:user) do
      User.create(email:'abc@gmail.com', password: '123456', password_confirmation: '123456')
    end
    let(:category) do
      Category.create(name: 'Laptop')
    end

    context "success" do
      before do
        sign_in user
      end

      it "create a presisted product" do
        post :create, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
        expect(Product.count).to eql(1)
      end

      it "redirect_to products index pages" do
        post :create, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(products_path)
      end
    end

    context "failed" do
      it "does not create a new product in database without sign in user" do
        post :create, params: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}
        expect(Product.count).to eql(0)
      end

      it "does not create a new product in database with sign in user" do
        sign_in user
        post :create, params: { product: { product_name: '', quantity: '', unit_price: '', category_id: '' }}
        expect(Product.count).to eql(0)
      end

      it "render products new pages" do
        sign_in user
        post :create, params: { product: { product_name: '', quantity: '', unit_price: '', category_id: '' }}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    it "render show product page" do
      category = Category.create(name: 'Laptop')
      product = Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
      get :show, params: { id: product.id }
      expect(response).to have_http_status(200)
    end
  end
end
