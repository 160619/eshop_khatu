# frozen_string_literal: true

# Description/Explanation of ReviewsController class

class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id
    
    respond_to do |format|
      if @review.save
        html_comment_form = render_to_string(
          partial: 'comments/form',
          locals: { review: @review, comment: Comment.new }
        )
        @product.calculate_rating
        format.json { render json: review_serializer(html_comment_form), status: :created }
      else
        format.json { render json: @review.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit :content, :rating
    end

    def review_serializer(comment_form)
      {
        id: @review.id,
        content: @review.content,
        rating: @review.rating,
        user: {
          email: @review.user.email
        },
        product: {
          aggregate_rating: @product.reload.aggregate_rating
        },
        comment_form: comment_form
      }
    end

end
