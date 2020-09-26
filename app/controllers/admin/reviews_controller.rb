# frozen_string_literal: true

# Description/Explanation of Admin::ReviewsController class

class Admin::ReviewsController < AdminController
  before_action :find_review, only: %i[show edit update destroy]

  def index
    @admin_reviews = Review.all
  end

  def show;  end

  def new
    @admin_review = Review.new
  end

  def create
    @admin_review = Review.new(admin_review_params)

    if @admin_review.save
      redirect_to @admin_review, notice: 'Create review successfully.'
    else
      render :new
    end
  end

  def edit;  end

  def update
    if @admin_review.update(admin_review_params)
      redirect_to @admin_review, notice: 'Update review successfully.'
    else
      render :edit
    end
  end

  def destroy
    @admin_review.destroy
    redirect_to admin_reviews_url, notice: 'Delete review successfully'
  end

  private
    def admin_review_params
      params.require(:admin_review).permit :content, :rating
    end

    def find_review
      @admin_review = Review.find(params[:id])
    end
end
