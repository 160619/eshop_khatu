# frozen_string_literal: true

# Description/Explanation of Admin::CategoriesController class

class Admin::CategoriesController < AdminController
  before_action :find_category, only: %i[show edit update destroy]

  def index
    @categories = Category.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to admin_category_path(@category), notice: 'Create category successfully'
    else
      render :new
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: 'Delete category successfully'
  end

  def edit; end

  def update
    if @category.update_attributes(category_params)
      redirect_to admin_category_path(@category), notice: 'Updated category successfully'
    else
      render :edit
    end
  end

  def show;  end

  private
    def category_params
      params.require(:category).permit :name, :parent_id
    end

    def find_category
      @category = Category.find(params[:id])
    end
end
