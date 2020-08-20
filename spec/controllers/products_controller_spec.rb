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
  it "assigns a new product to @products" do
    get :new
    expect(response).to have_http_status(:success)
    expect(response).to render_template(:new)
  end

   it "befor create a presisted product" do
    get :new
    expect(assigns(:product)).to be_a_kind_of(Product)
  end
end

  describe "#create" do
    context "success" do
      it "create a presisted product" do
        category = Category.create name: 'Laptop'
        post :create, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
        expect(Product.count).to eql(1)
      end

      it "redirect_to products index pages" do
        category = Category.create name: 'Laptop'
        post :create, params: { product: { product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(products_path)
      end
    end

    context "failed" do
      it "does not create a new product in database" do
        category = Category.create name: 'Laptop'
        post :create, params: { product: { product_name: '', quantity: '', unit_price: '', category_id: ''}}
        expect(Product.count).to eql(0)
      end

      it "render products new pages" do
        category = Category.create name: 'Laptop'
        post :create, params: { product: { product_name: '', quantity: '', unit_price: '', category_id: ''}}
        expect(response).to render_template(:new)
      end
    end
  end
end
