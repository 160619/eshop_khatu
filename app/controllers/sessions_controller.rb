# frozen_string_literal: true

# Description/Explanation of SessionsController class

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      flash[:success] = 'Successfully login'
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash.now[:danger] = 'In Invalid email/password combination'
      render :new
    end
  end
end
