
# frozen_string_literal: true

# Description/Explanation of CategoriesController class

class CategoriesController < ApplicationController
 def index
   @categories = Category.order(created_at: :desc)
 end

 def new
   @category = Category.new
 end

 def create
   @category = Category.new category_params
   if @category.save
     flash[:success] = 'Create category successfully'
     redirect_to categories_path
   else
     flash.now[:alert] = 'Create category failed'
     render :new
   end
 end

 private
   def category_params
     params.require(:category).permit :name, :parent_id
   end
end
