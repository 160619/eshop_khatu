# frozen_string_literal: true

# Description/Explanation of ReviewsController class

class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      @product.calculate_rating
      flash[:notice] = 'Review added!'
      redirect_to product_path(@review.product)
    else
      flash[:error] = 'Failed to create review!'
      render 'product/show'
    end
  end

  def show
    @review = Review.find(params[:id])
    @product = @review.product
  end

  private
    def review_params
      params.require(:review).permit :content, :rating
    end
end
