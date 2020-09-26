# frozen_string_literal: true

# Description/Explanation of Admin::UsersController class

class Admin::UsersController < AdminController
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @admin_users = User.order(:id)
  end

  def show;  end

  def new
    @admin_user = User.new
  end

  def edit;  end

  def create
    @admin_user = User.new(admin_user_params)

    if @admin_user.save
      redirect_to @admin_user, notice: 'Create user successfully.'
    else
      render :new
    end
  end

  def update
    if @admin_user.update(admin_user_params)
      redirect_to @admin_user, notice: 'Update user successfully.'
    else
      render :edit
    end
  end

  def destroy
    @admin_user.destroy
    redirect_to admin_users_url, notice: 'Delete user successfully'
  end

  private
    def admin_user_params
      params.require(:admin_user).permit :email, :password, :password_confirmation
    end

    def find_user
      @admin_user = User.find(params[:id])
    end
end
