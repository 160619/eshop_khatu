# frozen_string_literal: true

# Description/Explanation of AdminController class

class AdminController < ActionController::Base
  before_action :authenticate_user!
end
