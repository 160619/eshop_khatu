require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "#create" do
    context "create a review successfully" do
      let(:user) do
        User.create(email:'abc@gmail.com', password: '123456', password_confirmation: '123456')
      end
      let(:category) do
        Category.create(name: 'Laptop')
      end
      let(:product) do
        Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
      end

      before do
        sign_in user
      end

      it "calculate product avg rating" do
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(product.reload.aggregate_rating).to eql(4)
      end

      it "create a review in database" do
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(Review.count).to eql(1)
      end

      it "redirect_to show product page" do
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(product_path(product))
      end

      it "responds with JSON formatted output" do
        post :create, format: :json, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(response).to have_content_type :json
      end
    end

    context 'create a review failed' do
      let(:user) do
        User.create(email:'abc@gmail.com', password: '123456', password_confirmation: '123456')
      end
      let(:category) do
        Category.create(name: 'Laptop')
      end
      let(:product) do
        Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
      end

      it "doesn't calculate product avg rating" do
        sign_in user
        post :create, params: { product_id: product.id, review: { content: '', rating: ''}}
        expect(product.reload.aggregate_rating).to eql(nil)
      end

      it "doesn't create a comment in database" do
        sign_in user
        post :create, params: { product_id: product.id, review: { content: '', rating: ''}}
        expect(Review.count).to eql(0)
      end

      it "render show product pages" do
        sign_in user
        post :create, params: { product_id: product.id, review: { content: '', rating: ''}}
        expect(response).to render_template('products/show')
      end

      it "redirect_to sign in page without sign in user" do
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
