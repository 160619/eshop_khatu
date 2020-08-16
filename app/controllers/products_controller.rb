# frozen_string_literal: true

# Description/Explanation of ProductsController class

class ProductsController < ApplicationController
  def index
    @products = Product.all
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

  private
    def product_params
      params.require(:product).permit :product_name, :quantity, :unit_price, :discontinued, :desc, :category_id
    end
end
