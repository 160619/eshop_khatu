# frozen_string_literal: true

# Description/Explanation of Admin::ProductsController class

class Admin::ProductsController < AdminController
  before_action :find_product, only: %i[show edit update destroy]

  def index
    @products = Product.all.order(:product_name)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    if @product.save
      redirect_to @product, notice: 'Product added!'
    else
      render :new
    end
  end

  def show;  end

  def edit;  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Update product successfully!'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_url, notice: 'Delete product successfully'
  end

  private
    def product_params
      params.require(:admin_product).permit :product_name, :quantity, :unit_price, :discontinued, :desc, :category_id
    end

    def find_product
      @product = Product.find(params[:id])
    end
end
