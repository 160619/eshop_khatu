# frozen_string_literal: true

# Description/Explanation of Admin::StaticPagesController class

class Admin::StaticPagesController < AdminController
  before_action :authenticate_user!

  def home; end
end
