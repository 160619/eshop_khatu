require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    context "create a comment successfully" do
      let(:user) do
        User.create(email:'abc@gmail.com', password: '123456', password_confirmation: '123456')
      end
      let(:category) do
        Category.create(name: 'Laptop')
      end
      let(:product) do
        Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
      end
      let(:review) do
        Review.create(product_id: product.id, content: 'advf', rating: 4, user_id: user.id)
      end

      before do
        sign_in user
      end

      it "create a comment in database" do
        post :create, params: { review_id: review.id, comment: { body: 'advf'}}
        expect(Comment.count).to eql(1)
      end

      it "redirect_to show product page" do
        post :create, params: { review_id: review.id, comment: { body: 'advf'}}
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
      let(:review) do
        Review.create(product_id: product.id, content: 'advf', rating: 4, user_id: user.id)
      end

      it "doesn't create a comment in database" do
        sign_in user
        post :create, params: { review_id: review.id, comment: { body: ''}}
        expect(Comment.count).to eql(0)
      end

      it "render show product pages" do
        sign_in user
        post :create, params: { review_id: review.id, comment: { body: ''}}
        expect(response).to render_template('products/show')
      end

      it "redirect_to sign in page" do
        post :create, params: { review_id: review.id, comment: { body: 'advf'}}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
