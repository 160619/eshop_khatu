# frozen_string_literal: true

# Description/Explanation of CommentsController class

class CommentsController < ApplicationController
  def new
    @review = Review.find(params[:review_id])
    @comment = @review.comments.new
  end

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = 'Comment added!'
      redirect_to review_path(@comment.review)
    else
      flash[:error] = 'Failed to create comment!'
      render 'product/show'
    end
  end

  private
    def comment_params
      params.require(:comment).permit :body
    end
  end
