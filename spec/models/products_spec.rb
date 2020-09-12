require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#calculate_rating' do
    let(:user) do
      User.create(email: 'demo@gmail.com', password: '123456', password_confirmation: '123456')
    end
    let(:category) do
      Category.create(name: 'Apple')
    end
    let(:product) do
      Product.create(product_name: 'Macbook 2015', quantity: 50, unit_price: 200, category_id: category.id)
    end

    before do
      Review.create(product_id: product.id, content: 'a' * 20, rating: 5, user_id: user.id)
    end

    it 'calculates product rating' do
      product.calculate_rating
      expect(product.aggregate_rating).to eql(5)
    end
  end
end
