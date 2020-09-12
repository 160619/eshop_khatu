# frozen_string_literal: true

# Description/Explanation of ProductsController class

class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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
    @reviews = @product.reviews.order("created_at DESC")
    @review = @product.reviews.new
  end

  private
    def product_params
      params.require(:product).permit :product_name, :quantity, :unit_price, :discontinued, :desc, :category_id
    end
end
