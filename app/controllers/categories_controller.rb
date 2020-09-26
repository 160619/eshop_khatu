
# frozen_string_literal: true

# Description/Explanation of CategoriesController class

class CategoriesController < ApplicationController
 def index
   @categories = Category.order(created_at: :desc)
 end
end
