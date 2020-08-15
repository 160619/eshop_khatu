# frozen_string_literal: true

# Description/Explanation of UsersController class

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Successfully register'
      redirect_to root_path
    else
      flash.now[:alert] = 'Register failed'
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit :email, :password, :password_confirmation
    end
end
