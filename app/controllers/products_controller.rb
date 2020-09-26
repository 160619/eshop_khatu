# frozen_string_literal: true

# Description/Explanation of ProductsController class

class ProductsController < ApplicationController
  def index
    @products = Product.all.order(:product_name)
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.order("created_at DESC")
    @review = @product.reviews.new
    @comment = @review.comments.new
  end

  private
    def product_params
      params.require(:product).permit :product_name, :quantity, :unit_price, :discontinued, :desc, :category_id
    end
end
