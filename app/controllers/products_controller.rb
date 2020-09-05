# frozen_string_literal: true

# Description/Explanation of ProductsController class

class ProductsController < ApplicationController
  def index
    @products = Product.all.order(:product_name)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:notice] = 'Product added!'
      redirect_to products_path
    else
      flash[:error] = 'Failed to create product!'
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = Review.where(product_id: @product.id).order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
    @product.update_attribute(:aggregate_rating, @avg_review)
  end

  private
    def product_params
      params.require(:product).permit :product_name, :quantity, :unit_price, :discontinued, :desc, :category_id
    end
end
