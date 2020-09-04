# frozen_string_literal: true

# Description/Explanation of ReviewsController class

class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to product_path(@review.product)
    else
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit :content, :rating, :product_id, :user_id
    end
end
