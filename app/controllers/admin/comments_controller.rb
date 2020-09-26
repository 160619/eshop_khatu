# frozen_string_literal: true

# Description/Explanation of Admin::CommentsController class

class Admin::CommentsController < AdminController
  before_action :find_comment, only: %i[show edit update destroy]

  def index
    @admin_comments = Comment.all
  end

  def show;  end

  def new
    @admin_comment = Comment.new
  end

  def edit;  end

  def create
    @admin_comment = Comment.new(admin_comment_params)

    if @admin_comment.save
      redirect_to admin_comment_path(@admin_comment), notice: 'Create comment successfully.'
    else
      render :new
    end
  end

  def update
    if @admin_comment.update(admin_comment_params)
      redirect_to admin_comment_path(@admin_comment), notice: 'Update comment successfully.'
    else
      render :edit
    end
  end

  def destroy
    @admin_comment.destroy
    redirect_to admin_comments_url, notice: 'Delete comment successfully'
  end

  private
    def admin_comment_params
      params.require(:admin_comment).permit :body, :review_id, :user_id
    end

    def find_comment
      @admin_comment = Comment.find(params[:id])
    end
end
