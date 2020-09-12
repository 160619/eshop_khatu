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
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(product.reload.aggregate_rating).to eql(nil)
      end

      it "doesn't create a review in database" do
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(Review.count).to eql(0)
      end

      it "render sign in page" do
        post :create, params: { product_id: product.id, review: { content: 'advf', rating: 4}}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "#show" do
    it "render show product page" do
      category = Category.create(name: 'Laptop')
      product = Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
      user = User.create(email:'abc@gmail.com', password: '123456', password_confirmation: '123456')
      review = Review.create(product_id: product.id, content: 'advf', rating: 4, user_id: user.id)
      get :show, params: { product_id: product.id, id: review.id }
      expect(response).to have_http_status(200)
    end
  end
end
